% This script was designed to produce a sine wave motion of arduino servo
% from amplitude and frequency wavelengths.
% If a threshold is met, it will exhibit a reward. ~ March 4, 2015
function [reward] = ForrestSinewave_Macmic()
    %Variables
    phase = 10*(pi)/180;
    xshift = 0;
    yshift = 50;
    amp = 50;
    thresh = 0.7;
    reward = 0;

    %Main
    Initialize();
    reward = shakeItBaby(phase,xshift,yshift,amp,thresh);
    destroy();
end

function [] = Initialize()
    %Cleanup
    %clear all
    %clc
    %rng('shuffle')
    %Arduino Stuff
    global a macRec
    a = arduino('/dev/tty.usbmodem1411');
    a.servoAttach(8);
    %Microphone Stuff
    %Use audiodevinfo(1,:) to figure out ID to use.
    %Can use audiodevinfo(1,44100,16,1) to auto find a working ID
    macRec = audiorecorder(44100,16,1,1);
end

function [reward] = shakeItBaby(phase,xshift,yshift,amp, thresh)
    %Start
    global a macRec
    tic
    record(macRec);
    %Iterate
    for t = 1:200
        pos = round(amp*sin(t*phase+xshift)+yshift);
        posT(2,t) = toc;
        posT(1,t) = pos;
        a.servoWrite(8,pos);
        pause(0.03);
    end
    stop(macRec);
    %Determine Reward
    micData = getaudiodata(macRec, 'int16');
    micRMS = sqrt(mean(micData.^2));
    display(micRMS)
    if max(micRMS) > thresh
        reward = 1;
        display('Reward has been given');
    elseif max(micRMS)< thresh
        reward = 0;
        display('Reward was not given');
    end
    %Plot Figures
    x = interp1(size(micData),posT(1,:)')
    
    figure;
    subplot(2,1,1)
    plot(x');
    xlabel('Iteration')
    title('Servo Positions')
% 
%     subplot(3,1,3)
%     plot(posT(2,:));
%     xlabel('Time Step Iteration')
%     ylabel('Actual Time')
%     title('Time Compare')

    subplot(2,1,2)
    plot(micData);
    title('Audio data')
end

function [] = destroy()
    delete(instrfind({'Port'},{'/dev/tty.usbmodem1411'}));
end
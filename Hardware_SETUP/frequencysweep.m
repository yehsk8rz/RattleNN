%This script runs a frequency sweep between a set maxHz and minHz value.
%It will plot real time values with analog reads and f with RMS (x10)

format shortg
cIN = clock;

%Arduino and Microphone Initialization
global ard macRec
if ~isempty(instrfind({'Port'},{'/dev/tty.usbmodem1411'}))
    delete(instrfind({'Port'},{'/dev/tty.usbmodem1411'}))
end
% vid = videoinput('macvideo',1,'ARGB32_1920x1080'); %: MicrosoftLifeCam:'macvideo',2,'YUY2_640x480'
% a=imaqhwinfo('macvideo',1)
% % Find a list of supported video formats: 
% a.SupportedFormats
% set(vid,'FramesPerTrigger',300);
% start(vid);
% wait(vid,Inf);
% % Retrieve the frames and timestamps for each frame.
% [frames,time] = getdata(vid, get(vid,'FramesAvailable'));
% % Calculate frame rate by averaging difference between each frame's timestamp
% framerate = mean(1./diff(time))
% % How often frames are stored from the video stream. For instance, if we 
% % set it to 5, then only 1 in 5 frames is kept -- the other 4 frames will 
% % be discarded. Using the framerate, determine how often you want to get frames
% set(vid,'FrameGrabInterval',1);
% % To determine how many frames to acquire in total, calculate the total 
% % number of frames that would be acquired at the device's frame rate, and then divide by the FrameGrabInterval.
% capturetime = 10;
% interval = get(vid,'FrameGrabInterval');
% numframes = floor(capturetime * framerate / interval)
ard = arduino('/dev/tty.usbmodem1411');
ard.servoAttach(9);
macRec = audiorecorder(44100,16,1,0);   %Use audiodevinfo(1,:) to figure out ID to use.Can also use audiodevinfo(1,44100,16,1) to auto find a working ID.(Typically 1 for FYmbp 1 , and 0 for EOCmac)
pos = 90;
micRMS = 0;
ard.servoWrite(9,pos);
xshift = 90;
phase = 0;
maxHz = 20;
minHz = 5;
fDiv = 1;
%Create Frequency Sweep Array
j = 1;
for i = minHz:fDiv:maxHz
    f(j) = i;
    j=j+1;
end

%Arm movement
%Preestablish arrays for speed:
analogInfo = zeros(size(f,1),500);
digitalInfo = zeros(size(f,1),500);
%rtdInfo = zeros(2,100);
t = zeros(size(f,1), 1000);

for m = 1:size(f,2)

% %For a large # of frames. Log images to disk as avi rather than memory
% set(vid,'LoggingMode','disk');
% fprintf('marker 1\n')
% %Set avi file name and play back frame rate
% filename= ['Servo1_',num2str(m),'.avi'];
% fprintf('marker 2\n')
% avi = VideoWriter(filename);
% fprintf('marker 3\n')
% set(vid,'DiskLogger',avi);
% %Similar to mic recording, data aquisition does not tie up Matlab
% fprintf('marker 4\n')
% triggerconfig(vid,'manual');
% start(vid); %There'll be a delay here, but nothing is being captured
% fprintf('marker 5\n')
% pause(6);
% fprintf('Start Video w/ Frequency %f\n', f(1,m))
% trigger(vid); %Use this line when you want the capture to start. There should be very little delay.
% %While t~= 100
%     fprintf('Start Sound w/ Frequency %f\n', f(1,m))
    record(macRec);
    tic
    t(m,1) = 0;
    k = 1;
    while t(m,k) * f(1,m) < 6 * pi
        pos = round(20 * sin(t(m,k) * f(1,m) + phase) + xshift); %%(digital:70:110) (analog:191:259)
        %Error Check on pos
        if pos > 179
            pos = 179;
        elseif pos < 1
            pos = 1;
        end
        ard.servoWrite(9,pos);
%         analogInfo(m,k) = ard.analogRead(1);
        digitalInfo(m,k) = pos;
        rtd = toc; %Real Time Difference
        pause(0.027-rtd); %%Hz = f/.027
        tic
        t(m,k + 1) = t(m,k) + 0.027; %collect real time difference values during movement
        k = k + 1;
    end
    stop(macRec);
%     stop(vid);
%     fprintf('Completed Frequency %f\n\n\n', f(1,m))
%     %rtdInfo(2,m) = mean(rtdInfo(1,:)); %store mean value of rtd for that movement
%     avi = get(vid,'DiskLogger');
    %Move arm to neutral position
    pos = round(20*sin(f(1,m)*((pi)/180)+phase)+xshift);
    ard.servoWrite(9,pos);
    pause(2);
    %Determine Reward
    micData = getaudiodata(macRec, 'int16');
    micRMS = sqrt(mean(micData.^2));
    soundInfo(1,m) = micRMS;
end
figure(1)
%subplot(2,2,1) 
plot(soundInfo(1,:))
title('soundInfo')
xlabel('frequency/fDiv')
ylabel('RMS')
% subplot(2,2,2)
% plot(analogInfo(10,:))
% title('10Hz-AnalogInfo')
% xlabel('Timestep')
% ylabel('analog value')
% subplot(2,2,3)
% plot(max(analogInfo)-min(analogInfo))
% title('Servo Stability')
% xlabel('timestep')
% ylabel('analog difference')
% subplot(2,2,4)
% plot(mean(analogInfo'))
% title('Mean Analog Values')
% xlabel('frequency')
% ylabel('analog value')
% 
% delete(vid);
% clear vid;

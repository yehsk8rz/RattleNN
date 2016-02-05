%This script runs a frequency sweep between a set maxHz and minHz value.
%It will plot real time values with analog reads and f with RMS (x10)

format shortg
cIN = clock;

%Arduino and Microphone Initialization
global ard macRec
if ~isempty(instrfind({'Port'},{'/dev/tty.usbmodem1411'}))
    delete(instrfind({'Port'},{'/dev/tty.usbmodem1411'}))
end
ard = arduino('/dev/tty.usbmodem1411');
ard.servoAttach(9);
macRec = audiorecorder(44100,16,1,0);   %Use audiodevinfo(1,:) to figure out ID to use.Can also use audiodevinfo(1,44100,16,1) to auto find a working ID.(Typically 1 for FYmbp 1 , and 0 for EOCmac)
pos = 90;
micRMS = 0;
ard.servoWrite(9,pos);
xshift = 90;
phase = 1;
maxHz = 10;
minHz = 0.1;
fDiv = 0.1;
%Create Frequency Sweep Array
j = 1;
for i = minHz:fDiv:maxHz
    f(1,j) = i;
    j=j+1;
end

%Arm movement
%Preestablish arrays for speed:
analogInfo = zeros(size(f,2),100);
digitalInfo = zeros(size(f,2),100);
rtdInfo = zeros(2,100);

for m = 1:size(f,2)
    record(macRec);
    tic
    for k = 1:100
        pos = round(20*sin(k*f(1,m)*((pi)/180)+phase)+xshift);
        %Error Check on pos
        if pos > 179
            pos = 179;
        elseif pos < 1
            pos = 1;
        end
        ard.servoWrite(9,pos);
        analogInfo(m,k) = ard.analogRead(1);
        digitalInfo(m,k) = pos;
        rtd = toc; %Real Time Difference
        pause(0.03-rtd);
        tic
        rtdInfo(1,k)=rtd; %collect real time difference values during movement
    end
    stop(macRec);
    rtdInfo(2,m) = mean(rtdInfo(1,:)); %store mean value of rtd for that movement
    %Move arm to neutral position
    ard.servoWrite(9,xshift);
    %Determine Reward
    micData = getaudiodata(macRec, 'int16');
    micRMS = sqrt(mean(micData.^2));
    soundInfo(1,m) = micRMS;
end
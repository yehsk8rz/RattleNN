% Video recording testing
% use imaqhwinfo to find the name of installed devices. be sure the support
% packages are installed.

vid = videoinput('macvideo',1,'YCbCr422_1280x720');
a=imaqhwinfo('macvideo',1)
% Find a list of supported video formats: 
a.SupportedFormats
set(vid,'FramesPerTrigger',100);
start(vid);
wait(vid,Inf);

% Retrieve the frames and timestamps for each frame.
[frames,time] = getdata(vid, get(vid,'FramesAvailable'));

% Calculate frame rate by averaging difference between each frame's timestamp
framerate = mean(1./diff(time))

% How often frames are stored from the video stream. For instance, if we 
% set it to 5, then only 1 in 5 frames is kept -- the other 4 frames will 
% be discarded. Using the framerate, determine how often you want to get frames
set(vid,'FrameGrabInterval',10);

% To determine how many frames to acquire in total, calculate the total 
% number of frames that would be acquired at the device's frame rate, and then divide by the FrameGrabInterval.
capturetime = 30;
interval = get(vid,'FrameGrabInterval');
numframes = floor(capturetime * framerate / interval)

%For a large # of frames. Log images to disk as avi rather than memory
set(vid,'LoggingMode','disk');

%Set avi file name and play back frame rate
avi = VideoWriter('timelapsevideo.avi');
set(vid,'DiskLogger',avi);

%Similar to mic recording, data aquisition does not tie up Matlab
triggerconfig(vid,'manual');
start(vid); %There'll be a delay here, but nothing is being captured
trigger(vid); %Use this line when you want the capture to start. There should be very little delay.
%While t~= 100
wait(vid,Inf); % Wait for the capture to complete before continuing.

%retrieve avi file object and close function to release resources related
%to it. Also free hardware resources associated with it.
avi = get(vid,'DiskLogger');
%avi = close(avi);
delete(vid);
clear vid;



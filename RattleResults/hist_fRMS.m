newT = 300
%Plot Yoked Histogram of frequencies
for h = 1:5
    load(['rattle_daspnet_reservoir_run',num2str(h),'_yoke.mat']);
    fhist(1,((h*newT+1)-newT):(h*newT))=trialInfo(2,:);
end
figure(1)
histogram(fhist)
title('Yoked Frequency Distribution')
xlabel('Frequency')
ylabel('Occurences')
%Plot Yoked Histogram of RMS
for h = 1:5
    load(['rattle_daspnet_reservoir_run',num2str(h),'_yoke.mat']);
    RMShist(1,((h*newT+1)-newT):(h*newT))=trialInfo(1,:);
end
figure(2)
histogram(RMShist)
title('Yoked RMS Distribution')
xlabel('RMS')
ylabel('Occurences')

%Plot Histogram of frequencies
for h = 1:5
    load(['rattle_daspnet_reservoir_run',num2str(h),'.mat']);
    fhist(1,((h*newT+1)-newT):(h*newT))=trialInfo(2,:);
end
figure(3)
histogram(fhist)
title('Frequency Distribution')
xlabel('Frequency')
ylabel('Occurences')
%Plot Histogram of RMS
for h = 1:5
    load(['rattle_daspnet_reservoir_run',num2str(h),'.mat']);
    RMShist(1,((h*newT+1)-newT):(h*newT))=trialInfo(1,:);
end
figure(4)
histogram(RMShist)
title('RMS Distribution')
xlabel('RMS')
ylabel('Occurences')
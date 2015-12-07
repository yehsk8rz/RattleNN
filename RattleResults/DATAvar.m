datafile = fopen('800data.csv','w')
%run 1-10
for t = 1:5
    load(['rattle_daspnet_reservoir_run',num2str(t),'.mat']);
    for t = 1:800
        fprintf(datafile,[id,',',num2str(0),',',num2str(t),',',num2str(trialInfo(1,t)),',',num2str(trialInfo(2,t)),'\n']);
end
end
%yoked runs 1-10
for t = 1:5
    load(['rattle_daspnet_reservoir_run',num2str(t),'_yoke.mat']);
    for t = 1:800
        fprintf(datafile,[id,',',num2str(1),',',num2str(t),',',num2str(trialInfo(1,t)),',',num2str(trialInfo(2,t)),'\n']);
    end
end
fclose('all')
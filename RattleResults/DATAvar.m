datafile = fopen('data.csv','w')
%trial 1-10
for t = 1:10
    load(['rattle_daspnet_reservoir_trial',num2str(t),'.mat']);
    for t = 1:300
        fprintf(datafile,[id,',',num2str(0),',',num2str(t),',',num2str(trialInfo(1,t)),',',num2str(trialInfo(2,t)),'\n']);
    end
end
%yoked 1-10
for t = 1:10
    load(['rattle_daspnet_reservoir_trial',num2str(t),'_yoke.mat']);
    for t = 1:300
        fprintf(datafile,[id,',',num2str(1),',',num2str(t),',',num2str(trialInfo(1,t)),',',num2str(trialInfo(2,t)),'\n']);
    end
end
fclose('all')
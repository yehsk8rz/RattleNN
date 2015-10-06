%Obtain timeInfo1 data from trials 1-10
% for j = 1:10
%     trial = ['trial',num2str(j)];
%     workspacename = ['rattle_recur_daspnet_reservoir_',trial,'.mat'];
%     load(workspacename);
%     fig = figure;
%     plot(timeInfo(1,:));
%     titlee = [trial,': timeInfor1'];
%     title(titlee);
%     print(fig,trial,'-dpng')
% end

%Obtain timeInfo1 data from yoked trials 1-10
% for k = 1:10
%     trial = ['trial',num2str(k)];
%     workspacename = ['rattle_recur_daspnet_reservoir_',trial,'_yoke.mat'];
%     load(workspacename);
%     fig = figure;
%     plot(timeInfo(1,:));
%     titlee = [trial,'_Yoked: timeInfor1'];
%     title(titlee);
%     print(fig,trial,'-dpng')
% end

%plot distribution of sound file lengths
% for i = 1:10
%     trial = ['trial',num2str(i)];
%     workspacename = ['rattle_daspnet_reservoir_',trial,'.mat'];
%     load(workspacename);
%     for l =1:300
%         timein(1,(l-300)+(i*300)) = timeInfo(1,l);
%         % if a value equals 0, replace with NaN to keep figure scaled well
%         % use:timein(timein==0)=NaN;
%         %mode(timein) will tell you most occuring value
%         timein = nonzeros(timein)';
%     end
%     histfit(timein(1,:));
%     title('distribution of sound lengths');
%
% end

%RRT in wrong place. this is an alternate method for trial-time
%derivative
for m = 1:10
    trial = ['trial',num2str(m)];
    workspacename = ['rattle_daspnet_reservoir_',trial,'_yoke.mat'];
    load(workspacename);
    runTime(1,m)= ((((cIN(3)*1440)+(cIN(4)*60)+cIN(5))*60)+cIN(6))/60; %end result is minutes
end
for n = 1:6
    dy(1,n) = runTime(1,n+1)-runTime(1,n);
end
    plot(dy(1,:));
    title('Real run time for Yoked rtd_Trials 1-7 (Min)');
    xlabel('Trials 1-7 *NOTE: last 3 trials carry to next month ')
    ylabel('Clock Time (min)')

% %Plot Real Run Time (RRT) for each trial over time (1-10)
% for m = 1:10
%     trial = ['trial',num2str(m)];
%     workspacename = ['rattle_daspnet_reservoir_',trial,'.mat'];
%     load(workspacename);
%     runTime(1,m)=RRT;
%     histfit(runTime(1,:));
%     title('Real run time for Trials 1-10');
%     xlabel('Trials 1-10')
%     ylabel('length (min)')
% end
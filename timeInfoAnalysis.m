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
for i = 1:10
    trial = ['trial',num2str(i)];
    workspacename = ['rattle_recur_daspnet_reservoir_',trial,'.mat'];
    load(workspacename);
    for l =1:300
        timein(1,(l-300)+(i*300)) = timeInfo(1,l);
        % if a value equals 0, replace with NaN to keep figure scaled well
        % use:timein(timein==0)=NaN;
        %mode(timein) will tell you most occuring value
        timein = nonzeros(timein)';
    end
    histfit(timein(1,:));
    title('distribution of sound lengths');
    
end
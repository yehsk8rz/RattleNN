
for i = 1:10
    trial = ['trial',num2str(i)]
    rattle_WTA_daspnet_reservoir(trial,300,'microphone',1:100,'false',0)
    rattle_WTA_daspnet_reservoir(trial,300,'microphone',1:100,'true',0)
end
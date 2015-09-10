
for i = 1:10
    trial = ['trial',num2str(i)]
    rattle_daspnet_reservoir(trial,300,'microphone',1:100,4,'false',0)
    rattle_daspnet_reservoir(trial,300,'microphone',1:100,4,'true',0)
end
    
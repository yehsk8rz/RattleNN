
for i = 1:10
    trial = ['DEMO',num2str(i)]
    %Run a Trial
    rattle_daspnet_reservoir(trial,300,'microphone','fsine',1:100,'false',1)
    %Run a yoke control
    rattle_daspnet_reservoir(trial,300,'microphone','fsine',1:100,'true',1)
end
    
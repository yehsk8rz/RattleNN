
for i = 1:5
    run = ['run',num2str(i)]
    rattle_daspnet_reservoir(run,600,'microphone','fsine',1:100,'false',0)
    rattle_daspnet_reservoir(run,600,'microphone','fsine',1:100,'true',0)
end
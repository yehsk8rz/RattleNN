
for i = 1:5
    run = ['run',num2str(i)]
    rattle_recur_daspnet_reservoir(run,400,'microphone',1:100,'false',0)
    rattle_recur_daspnet_reservoir(run,400,'microphone',1:100,'true',0)
end
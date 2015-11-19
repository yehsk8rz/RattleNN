function [] = rattle_daspnet_reservoir(id,newT,reinforcer,motControl,outInd,yoke,plotOn)
% RATTLE_WTA_DASPNET_RESERVOIR Neural network model of the development of reduplicated rattle shaking in human infancy.
%
% Description of Input Arguments:
% id            Unique identifier for this simulation. Must not contain white space.
% newT          Time experiment is to run in seconds. Can specify new times (longer or shorter)
%               for experimental runs by changing this value when a simulation is restarted.
% reinforcer    Type of reinforcement. Can be 'microphone'.('human' is also
%               mentioned)
% motControl:
%           WTA:
%               This version uses a "Winner Takes All" approach to selecting from a
%               frequency bank to control sine movement
%           servo:
%               This version takes a simpler approach based on Georgopoulos et al.
%               population encoding of precise servo position
%           fsine:
%               This verson sums motor outpus spikes for a second to determine a sine
%               wave frequency via weighted sum.
%           ifourier:
%               This version chooses from a randomly initialized phase(0-180)
%               and frequency(5-10) to produce two sinewaves, constructed
%               totgether via inverse fourier tansform.
% outInd        Index of reservoir neurons that project to motor neurons. Length of this vector must be even. Recommended vector is 1:100
% muscscale     Scales activation sent to Praat. Recommended value is 4
% yoke          Indicates whether to run an experiment or yoked control simulation. Set to 'false' to run a regular simulation.
%               Set to 'true' to run a yoked control. There must alread have been a simulation of the same name run with its
%               data on the MATLAB path for the simulation to yoke to.
% plotOn        Enables plots of several simulation parameters. Set to 0 to disable plots, and 1 to enable.
%
% Example of Use:
% rattle_daspnet_reservoir('run',300,'microphone','WTA',1:100,'false',1);
%
% Authors: Forrest Yeh and Anne S. Warlaumont
% Cognitive and Information Sciences
% University of California, Merced
% email: fyeh.ca@gmail.com or anne.warlaumont@gmail.com or
% Website: http://www.annewarlaumont.org/lab/
% May 2015


%INITIALIZATIONS AND LOADING%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
format shortg
cIN = clock;

rng shuffle;
% Initialization.
DAinc = 1; % Amount of dopamine given during reward.
sm = 4; % Maximum synaptic weight.
testint = 1; % Number of seconds between vocalizations.
% Directory names for data.
wavdir = [id, '_Wave'];
firingsdir = [id, '_Firings'];
workspacedir = [id, '_Workspace'];
yokeworkspacedir = [id, '_YokedWorkspace'];
% Error Checking.
if(any(isspace(id)))
    disp('Please choose an id without spaces.');
    return
end
% Creating data directories.
if ~exist(wavdir, 'dir')
    mkdir(wavdir);
else
    addpath(wavdir);
end
if ~exist(firingsdir, 'dir')
    mkdir(firingsdir);
else
    addpath(firingsdir);
end
if ~exist(workspacedir, 'dir')
    mkdir(workspacedir);
else
    addpath(workspacedir);
end
if strcmp(yoke, 'true')
    if ~exist(yokeworkspacedir, 'dir')
        mkdir(yokeworkspacedir);
    else
        addpath(yokeworkspacedir);
    end
end
% Creating workspace names.
if strcmp(yoke,'false')
    workspaceFilename=[workspacedir,'/rattle_daspnet_reservoir_',id,'.mat'];
elseif strcmp(yoke,'true')
    % Where to put the yoked control simulation data.
    workspaceFilename=[yokeworkspacedir,'/rattle_daspnet_reservoir_',id,'_yoke.mat'];
    % Where to find the original simulation data.
    yokeSourceFilename=[workspacedir,'/rattle_daspnet_reservoir_',id,'.mat'];
end
if exist(workspaceFilename, 'file') > 0
    load(workspaceFilename);
else
    M=100; % number of synapses per neuron
    D=1; % maximal conduction delay
    % excitatory neurons % inhibitory neurons % total number
    Ne=800; Ni=200; N=Ne+Ni; %usually, Ne = 800, Ni = 200
    Nout = length(outInd);
    Nmot=Nout; % Number of motor neurons that the output neurons in the reservoir connect to.
    a=[0.02*ones(Ne,1); 0.1*ones(Ni,1)]; % Sets time scales of membrane recovery variable.
    d=[ 8*ones(Ne,1); 2*ones(Ni,1)]; % Membrane recovery variable after-spike shift.
    a_mot=.02*ones(Nmot,1);
    d_mot=8*ones(Nmot,1);
    post=ceil([N*rand(Ne,M);Ne*rand(Ni,M)]); % Assign the postsynaptic neurons for each neuron's synapse in the reservoir.
    post_mot=repmat(1:Nmot,Nout,1); % All output neurons connect to all motor neurons.
    s=[rand(Ne,M);-rand(Ni,M)]; % Synaptic weights in the reservoir.
    sout=rand(Nout,Nmot); % Synaptic weights from the reservoir output neurons to the motor neurons.
    % Normalizing the synaptic weights.
    sout=sout./(mean(mean(sout)));
    sd=zeros(Nout,Nmot); % The change to be made to sout.
    for i=1:N
        delays{i,1}=1:M;
    end
    for i=1:Nout
        delays_mot{i,1}=1:Nmot;
    end
    STDP = zeros(Nout,1001+D);
    v = -65*ones(N,1); % Membrane potentials.
    v_mot = -65*ones(Nmot,1);
    u = 0.2.*v; % Membrane recovery variable.
    u_mot = 0.2.*v_mot;
    firings=[-D 0]; % All reservoir neuron firings for the current second.
    outFirings=[-D 0]; % Output neuron spike timings.
    motFirings=[-D 0]; % Motor neuron spike timings.
    DA=0; % Level of dopamine above the baseline.
    sec=0;
    rewcount=0;
    rew=[];
    
    % History variables.
    v_mot_hist={};
    trialInfo = NaN(4,newT);
    targetRMS = NaN;
    
    % Variables for saving data.
    vlstsec = 0; % Record of when v_mot_hist was last saved.
    
    switch reinforcer % Sets how often to save data.
        case 'human'
            SAVINTV = 10;
        otherwise
            SAVINTV = 100;
    end
end

%Arduino and Microphone Initialization
global ard macRec
if ~isempty(instrfind({'Port'},{'/dev/tty.usbmodem1421'}))
    delete(instrfind({'Port'},{'/dev/tty.usbmodem1421'}))
end
ard = arduino('/dev/tty.usbmodem1421');
ard.servoAttach(9);
macRec = audiorecorder(44100,16,1,1);   %Use audiodevinfo(1,:) to figure out ID to use.Can also use audiodevinfo(1,44100,16,1) to auto find a working ID.(Typically 1 for FYmbp 1 , and 0 for EOCmac)
pos = 90;
micRMS = 0;
ard.servoWrite(9,pos);

if sec==0
    thresh = 1;
    rewFract = 0;
    fprintf('%s%f\n','Threshold: ',thresh)
end
T=newT;
clearvars newT;

    % Special initializations for motor controls.
    if strcmp(motControl,'WTA') || strcmp(motControl,'fsine')
        phase = 0
        sumWTAspikes = zeros(1,5);

    elseif strcmp(motControl,'ifourier')
            fmax = 25;  %Set the highest frequency
            fmin = 1;   %Set the lowest frequency
            xshift = 90;
            phase = 360*rand(Nmot,1);  %Establish phase values for motor neurons
            f = fmin + (fmax-fmin).*rand(Nmot,1);   %Establish frequency values for motor neurons
            amplitude = zeros(Nmot,1);  %Determines weight of a given motor neuron's function
            ampscale = 1;   %Scaling factor for amplitude
            time = (30:30:3000); %starting at 30ms and going to 3 seconds, incriments of 30ms, the time alloted to one degree of change
            %time = (1:100);
    end
    
    % Special initializations for a yoked control.
    if strcmp(yoke,'true')
        load(yokeSourceFilename,'rew', 'yokedruntime');
        if(T > yokedruntime)
            T = yokedruntime;
        end
    end
    
    %RUNNING THE SIMULATION%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for sec=(sec+1):T % T is the duration of the simulation in seconds.
        display('********************************************');
        display(['Second ',num2str(sec),' of ',num2str(T)]);
        v_mot_hist{sec}=[]; % Record of all the membrane voltages of the motor neurons.
        % How long a yoked control could be run. Assumes rewards are
        % assigned for the current second only.
        yokedruntime = sec;
        
        for t=1:1000 % Millisecond timesteps
            %Random Thalamic Input.
            I=13*(rand(N,1)-0.5);
            I_mot=13*(rand(Nmot,1)-0.5);
            fired = find(v>=30); % Indices of fired neurons
            fired_out = find(v(outInd)>=30);
            fired_mot = find(v_mot>=30);
            v(fired)=-65; % Reset the voltages for those neurons that fired
            v_mot(fired_mot)=-65;
            u(fired)=u(fired)+d(fired); % Individual neuronal dynamics
            u_mot(fired_mot)=u_mot(fired_mot)+d_mot(fired_mot);
            % Spike-timing dependent plasticity computations:
            STDP(fired_out,t+D)=0.1; % Keep a record of when the output neurons spiked.
            for k=1:length(fired_mot)
                sd(:,fired_mot(k))=sd(:,fired_mot(k))+STDP(:,t); % Adjusting sd for synapses eligible for potentiation.
            end
            firings=[firings;t*ones(length(fired),1),fired]; % Update the record of when neuronal firings occurred.
            outFirings=[outFirings;t*ones(length(fired_out),1),fired_out];
            motFirings=[motFirings;t*ones(length(fired_mot),1),fired_mot];
            % For any presynaptic neuron that just fired, calculate the current to add
            % as proportional to the synaptic strengths from its postsynaptic neurons.
            k=size(firings,1);
            while firings(k,1)>t-D
                del=delays{firings(k,2),t-firings(k,1)+1};
                ind = post(firings(k,2),del);
                I(ind)=I(ind)+s(firings(k,2), del)';
                k=k-1;
            end;
            % Calculating currents to add for motor neurons.
            k=size(outFirings,1);
            while outFirings(k,1)>t-D
                del_mot=delays_mot{outFirings(k,2),t-outFirings(k,1)+1};
                ind_mot = post_mot(outFirings(k,2),del_mot);
                I_mot(ind_mot)=I_mot(ind_mot)+2*sout(outFirings(k,2), del_mot)';
                k=k-1;
            end;
            % Individual neuronal dynamics computations:
            v=v+0.5*((0.04*v+5).*v+140-u+I); % for numerical
            v=v+0.5*((0.04*v+5).*v+140-u+I); % stability time
            v_mot=v_mot+0.5*((0.04*v_mot+5).*v_mot+140-u_mot+I_mot); % step is 0.5 ms
            v_mot=v_mot+0.5*((0.04*v_mot+5).*v_mot+140-u_mot+I_mot);
            v_mot_hist{sec}=[v_mot_hist{sec},v_mot];
            u=u+a.*(0.2*v-u);
            u_mot=u_mot+a_mot.*(0.2*v_mot-u_mot);
            STDP(:,t+D+1)=0.95*STDP(:,t+D); % tau = 20 ms
            DA=DA*0.995; % Decrease in dopamine concentration over time.
            % Modify synaptic weights.
            if (mod(t,10)==0)
                sout=max(0,min(sm,sout+DA*sd));
                % Normalizing the synaptic weights.
                sout=sout./(mean(mean(sout)));
                sd=0.99*sd; % Decrease in synapse's eligibility to change over time.
            end;
            
            % Every testint seconds, use the motor neuron spikes to generate a sound.
            if (mod(sec,testint)==0)
                if strcmp(motControl,'WTA')
                    sumWTAspikes(1,1)=size(find(motFirings(:,2)<(Nmot/5)),1);
                    sumWTAspikes(1,2)=size(find(motFirings(:,2)>(Nmot/5)+1 & motFirings(:,2)<2*(Nmot/5)),1);
                    sumWTAspikes(1,3)=size(find(motFirings(:,2)>2*(Nmot/5)+1 & motFirings(:,2)<3*(Nmot/5)),1);
                    sumWTAspikes(1,4)=size(find(motFirings(:,2)>3*(Nmot/5)+1 & motFirings(:,2)<4*(Nmot/5)),1);
                    sumWTAspikes(1,5)=size(find(motFirings(:,2)>4*(Nmot/5)+1),1);
                    maxmusclspikes = find(sumWTAspikes(1,:)==max(sumWTAspikes(1,:)));
                    %Error checking (if groups spike same amount)
                    if maxmusclspikes == 0
                        wta = 0;
                    else
                        wta = maxmusclspikes;
                    end
                    
                elseif strcmp(motControl,'fsine')
                    firedmusc1pos=find(v_mot(1:Nmot/2)>=30); % Find out which of the jaw/lip motor neurons fired.
                    firedmusc1neg=find(v_mot(Nmot/2+1:end)>=30);
                    summusc1posspikes(t)=size(firedmusc1pos,1); % Sum the spikes at each timestep across the set of motor neurons.
                    summusc1negspikes(t)=size(firedmusc1neg,1);
                    
                elseif strcmp(motControl,'servo')
                    tic %should be placed at beginning of each ms iteration to make this operate in reall time with real network time
                    firedmusc1pos=find(v_mot(1:Nmot/2)>=30); % Find out which of the jaw/lip motor neurons fired.
                    firedmusc1neg=find(v_mot(Nmot/2+1:end)>=30);
                    pos = pos + 20*(size(firedmusc1pos,1)-size(firedmusc1neg,1));
                    record(macRec);
                    %Error Check on pos
                    if pos > 179
                        pos = 179;
                    elseif pos < 1
                        pos = 1;
                    end
                    ard.servoWrite(9,pos);
                    rtd = toc; %Real Time Difference
                    pause(0.01-rtd);
                    stop(macRec);
                    micData = getaudiodata(macRec, 'int16');
                    micRMS = (micRMS+(sqrt(mean(micData.^2))))/2;
                    
                elseif strcmp(motControl, 'ifourier')
                        fired_ifourier= find(v_mot(1:Nmot)>=30); %Find out which motor output neurons fired
                        if any(fired_ifourier)
                            for i = 1:size(fired_ifourier)
                            amplitude(fired_ifourier(i))= amplitude(fired_ifourier(i))+1; 
                            end  
                        end
                end
                
                if t==1000 % Based on the 1 s timeseries of smoothed summed motor neuron spikes, generate a sound.
                    if strcmp(motControl,'WTA')
                        f = 5*wta;
                        f = datasample(f,1);
                        
                    elseif strcmp(motControl,'fsine')
                        meanf = 7;
                        scale = 10;
                        f = ((sum(summusc1posspikes(101:1000))*0)+(sum(summusc1negspikes(101:1000))*(meanf*2)))/(sum(summusc1posspikes(101:1000))+sum(summusc1negspikes(101:1000)));
                        f =  f*scale-(meanf*scale)+meanf;
                        
                    elseif strcmp(motControl,'ifourier')
                        for time = 1:100
                        posArr(sec,time) = sum(ampscale*amplitude.*sin((f*time + phase) * pi / 180))+xshift;
                        end
                        amplitude = zeros(Nmot,1);
                        %overlay posArr plots
                        plot(posArr(sec,:))
                        xlabel('time')
                        ylabel('position')
                        title('Overlaid posArr Plots')
                        %hold on
                    end
                    
                    if strcmp(motControl,'WTA') || strcmp(motControl,'fsine')
                        xshift = 120;
                        record(macRec);
                        tic
                        for k = 1:100
                            pos = round(25*sin(k*f*((pi)/180)+phase)+xshift);
                            %Error Check on pos
                            if pos > 179
                                pos = 179;
                            elseif pos < 1
                                pos = 1;
                            end
                            ard.servoWrite(9,pos);
                            rtd = toc; %Real Time Difference
                            pause(0.03-rtd);
                            tic
                            timeInfo(2,k)=rtd; %collect real time difference values during movement
                        end
                        stop(macRec);
                        timeInfo(1,sec) = mean(timeInfo(2,100)); %store mean value of rtd for that movement
                        
                        %Move arm to neutral position
                        ard.servoWrite(9,xshift);
                        
                        %Determine Reward
                        micData = getaudiodata(macRec, 'int16');
                        micRMS = sqrt(mean(micData.^2));
                        trialInfo(2,sec) = f;
                        trialInfo(1,sec) = micRMS;
                        trialInfo(4,sec) = targetRMS*thresh;
                        fprintf('Frequency: %f\n',trialInfo(2,sec))
                        fprintf('Root Mean Square: %f\n',trialInfo(1,sec))
                        fprintf('Threshold RMS: %f\n',trialInfo(4,sec))
                    end
                    
                    if strcmp(motControl,'servo')
                        trialInfo(2,sec) = pos;
                        trialInfo(1,sec) = micRMS;
                        trialInfo(4,sec) = targetRMS*thresh;
                        fprintf('Servo Position: %f\n',trialInfo(2,sec))
                        fprintf('Root Mean Square: %f\n',trialInfo(1,sec))
                        fprintf('Threshold RMS: %f\n',trialInfo(4,sec))
                    end
                    if strcmp(motControl,'ifourier')
                        record(macRec);
                        tic
                        for k = 1:size(posArr,2)
                            %Error Checking on posArr
                            if posArr(sec,k) > 179
                                posArr(sec,k) = 179;
                            elseif posArr(sec,k) < 1
                                posArr(sec,k) = 1;
                            end
                            ard.servoWrite(9,round(posArr(sec,k)));
                            rtd = toc; %Real Time difference
                            pause(0.03-rtd);
                            tic
                        end
                        stop(macRec);
                        
                        %Move arm to neutral position
                        ard.servoWrite(9,xshift);
                        
                        %Determine Reward
                        micData = getaudiodata(macRec, 'int16');
                        micRMS = sqrt(mean(micData.^2));
                        trialInfo(2,sec) = NaN;
                        trialInfo(1,sec) = micRMS;
                        trialInfo(4,sec) = targetRMS*thresh;
                        fprintf('Servo Position: %f\n',trialInfo(2,sec))
                        fprintf('Root Mean Square: %f\n',trialInfo(1,sec))
                        fprintf('Threshold RMS: %f\n',trialInfo(4,sec))
                    end
                    
                    % Assign Reward.
                    if strcmp(yoke,'true')
                        % Yoked controls use reward assigned from the
                        % experiment they are yoked to.
                        if any(rew==sec*1000+t)
                            display('rewarded');
                        else
                            display('not rewarded');
                        end
                    elseif strcmp(reinforcer, 'microphone')
                        if sec > 10
                            targetRMS = mean(trialInfo(1,sec-10:sec-1));
                            if micRMS > targetRMS
                                rew=[rew,sec*1000+t];
                                rewcount= rewcount+1;
                                fprintf(2,'%s\n','Reward has been given ')
                                trialInfo(3,sec) = 1;
                            else
                                display('Reward was not given')
                                trialInfo(3,sec) = 0;
                            end
                        end
                    end
                    % Display reward count information.
                    if strcmp(yoke,'false') && ~strcmp(reinforcer,'human')
                        display(['rewcount: ',num2str(rewcount)]);
                    end
                end
            end
            
            % If the human listener decided to reinforce (or if the yoked control
            % schedule says to reinforce), increase the dopamine concentration.
            if any(rew==sec*1000+t)
                DA=DA+DAinc;
            end
        end
        % Writing reservoir neuron firings for this second to a text file.
        if mod(sec,SAVINTV*testint)==0 || sec==T
            if strcmp(yoke,'false')
                firings_fid = fopen([firingsdir,'/rattle_daspnet_firings_',id,'_',num2str(sec),'.txt'],'w');
            elseif strcmp(yoke,'true')
                firings_fid = fopen([firingsdir,'/rattle_daspnet_firings_',id,'_yoke_',num2str(sec),'.txt'],'w');
            end
            for firingsrow = 1:size(firings,1)
                fprintf(firings_fid,'%i\t',sec);
                fprintf(firings_fid,'%i\t%i',firings(firingsrow,:));
                fprintf(firings_fid,'\n');
            end
            fclose(firings_fid);
        end
        
        % Make axis labels and titles for plots that are being kept.
        % ---- plot -------
        if plotOn
            hNeural = figure(103);
            set(hNeural, 'name', ['Neural Spiking for Second: ', num2str(sec)], 'numbertitle','off');
            subplot(4,1,1)
            plot(firings(:,1),firings(:,2),'.'); % Plot all the neurons' spikes
            title('Reservoir Firings', 'fontweight','bold');
            axis([0 1000 0 N]);
            subplot(4,1,2)
            plot(outFirings(:,1),outFirings(:,2),'.'); % Plot the output neurons' spikes
            title('Output Neuron Firings', 'fontweight','bold');
            axis([0 1000 0 Nout]);
            subplot(4,1,3)
            plot(motFirings(:,1),motFirings(:,2),'.'); % Plot the motor neurons' spikes
            title('Motor Neuron Firings', 'fontweight','bold');
            axis([0 1000 0 Nmot]);
            %subplot(4,1,4);
            %plot(smoothmusc(muscsmooth:1000,sec)); ylim([-.5,.5]); xlim([-100,900]); % Plot the smoothed sum of motor neuron spikes 1 s timeseries
            %title('Sum of Agonist/Antagonist Motor Neuron Activation', 'fontweight','bold');
            drawnow;
            hSyn = figure(113);
            set(hSyn, 'name', ['Synaptic Strengths for Second: ', num2str(sec)], 'numbertitle','off');
            imagesc(sout)
            set(gca,'YDir','normal')
            colorbar;
            title('Synapse Strength between Output Neurons and Motor Neurons', 'fontweight','bold');
            xlabel('postsynaptic motor neuron index', 'fontweight','bold');
            ylabel('presynaptic output neuron index', 'fontweight','bold');
            %Real Time trialInfo Plot
            hRMS = figure(123);
            set(hRMS,'name',('RMS-Frequency over time w/ Reward & Threshold'),'numbertitle','off');
            plot(1:sec,trialInfo(1,1:sec),'g')        %plot micRMS
            hold on
            plot(1:sec,trialInfo(2,1:sec),'r')        %plot f
            plot(1:sec,(trialInfo(4,1:sec)),'m')    % plot threshold RMS
            %plot(1:sec,(rewFract*100),'k*')   % plot reward fraction every 100s(*)
            xlabel('Time (sec)')
            legend('micRMS','Frequency','Threshold RMS','location','eastoutside')
        end
        % ---- end plot ------
        
        %sout_hist{sec}=sout;
        % Preparing STDP and firings for the following 1000 ms.
        STDP(:,1:D+1)=STDP(:,1001:1001+D);
        ind = find(firings(:,1) > 1001-D);
        firings=[-D 0;firings(ind,1)-1000,firings(ind,2)];
        ind_out = find(outFirings(:,1) > 1001-D);
        outFirings=[-D 0;outFirings(ind_out,1)-1000,outFirings(ind_out,2)];
        ind_mot = find(motFirings(:,1) > 1001-D);
        motFirings=[-D 0;motFirings(ind_mot,1)-1000,motFirings(ind_mot,2)];
        
        %Every 100 sec Re-assess Threshold
        if mod(sec,100) ==0
            if strcmp(reinforcer, 'human')
                rewFract = sum(trialInfo(3,(sec-SAVINTV+1):sec))/SAVINTV;
                if rewFract > .8
                    thresh = thresh+.1;
                end
                fprintf('%s%f\n', 'New Threshold: ',thresh)
            end
        end
        
        % Every so often, save the workspace in case the simulation is interupted all data is not lost.
        if mod(sec,SAVINTV*testint)==0 || sec==T
            display('Data Saving..... Do not exit program.');
            save(workspaceFilename, '-regexp', '^(?!(v_mot_hist)$).');
        end
        
        % Writing motor neuron membrane potentials to a single large text file.
        if mod(sec,SAVINTV*testint)==0 || sec==T
            if strcmp(yoke, 'false')
                vmhist_fid = fopen([workspacedir,'/v_mot_hist_',id,'.txt'],'a');
            elseif strcmp(yoke, 'true')
                vmhist_fid = fopen([yokeworkspacedir,'/v_mot_hist_',id,'_yoke.txt'],'a');
            end
            if(vlstsec == 0)
                fprintf(vmhist_fid, 'History of Motor Neuron Membrane Potentials:\n');
            end
            for sindx = (vlstsec+1):sec % Going through all the seconds needed data saved for.
                % Information formated to make data more human readable.
                fprintf(vmhist_fid, '\nSecond: %i\n',sindx);
                fprintf(vmhist_fid, 'Millisecond:\n\t\t');
                fprintf(vmhist_fid, '%f\t\t%f\t\t', 1:1000);
                fprintf(vmhist_fid, '\n');
                fprintf(vmhist_fid, 'Neuron: \n');
                % Appending new voltage data.
                for nrow = 1:size(v_mot_hist{sindx},1)
                    fprintf(vmhist_fid, '%i\t\t', nrow);
                    fprintf(vmhist_fid, '%f\t\t%f\t\t', v_mot_hist{sindx}(nrow, :));
                    fprintf(vmhist_fid, '\n');
                end
                fprintf(vmhist_fid, '\n');
            end
            fclose(vmhist_fid);
            vlstsec = sec; % Latest second of saving.
            
            %Print time when simulation ends
            cOUT = clock % when simulation ends
            RRT = (((cOUT(4)-cIN(4))*60))+(cOUT(5)-cIN(5)) %Real Run-time (Min)
            
            save(workspaceFilename, 'vlstsec', '-append'); % Saving the value of the last written second in case the simulation is terminated and restarted.
            display('Data Saved.');
        end
    end
end

%Call teacher() to set variable targetRMS to ideal sine wave
    function [targetRMS] = teacher()
        global ard macRec
        record(macRec);
        %Iterate
        tic
        for t = 1:100
            pos = round(25*sin(t*(7*(pi)/180))+120);
            posT(1,t) = pos;
            ard.servoWrite(9,pos);
            rtd = toc;
            pause(0.03-rtd);
        end
        stop(macRec);
        %Determine target Root Mean Square
        micData = getaudiodata(macRec, 'int16');
        targetRMS = sqrt(mean(micData.^2));
    end
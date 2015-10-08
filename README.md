RattleNN
========

This is the code for a neural network model of how infants learn to shake a rattle. 

The code is written in MATLAB. It requires ArduinoIO (http://www.mathworks.com/matlabcentral/fileexchange/47057-arduinoio-zip) to be installed. Upload adioes.pde to the Arduino microconroller.

The model is closely related to those described in these papers: 

A. S. Warlaumont, “Salience-based reinforcement of a spiking neural network leads to increased syllable production,” in IEEE International Conference on Development and Learning and Epigenetic Robotics (ICDL), 2013.

 A. S. Warlaumont, “A spiking neural network model of canonical babbling development,” in Proceedings of the 2012 IEEE International Conference on Development and Learning and Epigenetic Robotics (ICDL), 2012.

It borrows heavily from Izhikevich's (2007) model:

E. M. Izhikevich, “Solving the distal reward problem through linkage of STDP and dopamine signaling,” Cerebral Cortex, vol. 17, no. 10, pp. 2443–2452, 2007. Code available at http://izhikevich.org/publications/dastdp.htm


To analyze data:
1. use DATAvar.m to obtain .csv file from runs
2. Use rattleresults.R to see how RMS increases over time in regular runs vs yoked runs
3. Use RMSvsf.R to plot the RMS values vs frequency and see sigmoid nature of motions generated vs the sound they made.

arduino.m
-Must be in path in order to communicate with the micro controller. Typically use pin 9 on the arduino.

simloop.m
- perform consecutive runs separated into individual workspaces

simloopDEMO.m
-Used for presentations to show the output from network in real time. It will most likely not learn if the environment is loud.




Authors: Forrest Yeh and Anne S. Warlaumont

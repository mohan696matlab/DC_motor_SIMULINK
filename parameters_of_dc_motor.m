clc
clear all
close all

global Re L Rm J K Tc Ua ts

Re=2.4;
L=0.44;
J=0.08;
Rm=0.01;
K=0.139;
Tc=0.1;
Ua=40;

ts=0.1;



%% For Re and Rm faults
time = out.tout;
Im = out.Im;
Wm= out.Wm;
% 
fault_class="Im";
% 
Fault_type = repmat({fault_class}, length(time), 1);
% %%
FDI_tab = table(time,Im,Wm,Fault_type);
% % Save the Table
writetable(FDI_tab,sprintf('DC_motor_sensor_data\\%s_fault.csv', fault_class),'Delimiter',',','QuoteStrings',true)
% %% Plot
close all
subplot(1,2,1)
plot(time,Im)
xlabel('time')
ylabel('Im')
subplot(1,2,2)
plot(time,Wm)
xlabel('time')
ylabel('Wm')
sgtitle(sprintf('Fault Introduced - %s ', fault_class))
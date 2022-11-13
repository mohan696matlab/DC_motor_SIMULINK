

global Re L J Rm K Te Ua ts
%%
Re=2.4;
L=0.44;
J=0.08;
Rm=0.01;
K=0.139;
Te= 0.1;
Ua=120;

ts=0.1; %sampling time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Getting all the data from the DC Model
%% healthy condition




for fault_class =["Re",'L',"Rm",'J',"K1","K2"]
set_param(sprintf('DC_motor_model/Simulation Model/%s Fault Switch',fault_class),'sw','1');
end
set_param(sprintf('DC_motor_model/Sensor Measurement/I Fault Switch',fault_class),'sw','1');
set_param(sprintf('DC_motor_model/Sensor Measurement/W Fault Switch',fault_class),'sw','1');
fault_class = 'Helathy';
out = sim('DC_motor_model.slx');
Save_to_csv(working_condition,"Healthy",out)
%% Single Parameter Fault
% ['Re','Rm']

for fault_class =["Re","Rm"]


if strcmp(fault_class,'Healthy') == 0
    set_param(sprintf('DC_motor_model/Simulation Model/%s Fault Switch',fault_class),'sw','0');
    out = sim('DC_motor_model.slx');
    set_param(sprintf('DC_motor_model/Simulation Model/%s Fault Switch',fault_class),'sw','1');
end
 %% Extracting data from the Simulink Model
    Save_to_csv(working_condition,fault_class,out)
end    
%% Sensor Fault
% ['I','W']

for fault_class =["I","W"]


if strcmp(fault_class,'Healthy') == 0
    set_param(sprintf('DC_motor_model/Sensor Measurement/%s Fault Switch',fault_class),'sw','0');
    out = sim('DC_motor_model.slx');
    set_param(sprintf('DC_motor_model/Sensor Measurement/%s Fault Switch',fault_class),'sw','1');
end
 %% Extracting data from the Simulink Model
    Save_to_csv(working_condition,fault_class,out)
end    
%% For K-Fault both K1 and K2 needs to be activtated
    fault_class = 'K';
    
    set_param('DC_motor_model/Simulation Model/K1 Fault Switch','sw','0');
    set_param('DC_motor_model/Simulation Model/K2 Fault Switch','sw','0');
    out = sim('DC_motor_model.slx');
    set_param('DC_motor_model/Simulation Model/K1 Fault Switch','sw','1');
    set_param('DC_motor_model/Simulation Model/K2 Fault Switch','sw','1');
    
    %% Extracting data from the Simulink Model
Save_to_csv(working_condition,fault_class,out)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% For 2 simultenious fault
% (Re,L),(Rm,J),(Re,Rm)

fault_class1='Re';
fault_class2='Rm';

fault_class=sprintf('%s', append(fault_class1,' & ',fault_class2));

    set_param(sprintf('DC_motor_model/Simulation Model/%s Fault Switch',fault_class1),'sw','0');
    set_param(sprintf('DC_motor_model/Simulation Model/%s Fault Switch',fault_class2),'sw','0');
    out = sim('DC_motor_model.slx');
    set_param(sprintf('DC_motor_model/Simulation Model/%s Fault Switch',fault_class1),'sw','1');
    set_param(sprintf('DC_motor_model/Simulation Model/%s Fault Switch',fault_class2),'sw','1');

%% Extracting data from the Simulink Model
Save_to_csv(working_condition,fault_class,out)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% For 3 simultenious fault
% (Re,Rm,K)
fault_class1='Re';
fault_class2='Rm';
fault_class3='K';


fault_class=sprintf('%s', append(fault_class1,' & ',fault_class2,' & ',fault_class3));

    set_param(sprintf('DC_motor_model/Simulation Model/%s Fault Switch',fault_class1),'sw','0');
    set_param(sprintf('DC_motor_model/Simulation Model/%s Fault Switch',fault_class2),'sw','0');
    set_param('DC_motor_model/Simulation Model/K1 Fault Switch','sw','0');
    set_param('DC_motor_model/Simulation Model/K2 Fault Switch','sw','0');
    
    out = sim('DC_motor_model.slx');
    
    set_param(sprintf('DC_motor_model/Simulation Model/%s Fault Switch',fault_class1),'sw','1');
    set_param(sprintf('DC_motor_model/Simulation Model/%s Fault Switch',fault_class2),'sw','1');
    set_param('DC_motor_model/Simulation Model/K1 Fault Switch','sw','1');
    set_param('DC_motor_model/Simulation Model/K2 Fault Switch','sw','1');

%% Extracting data from the Simulink Model
Save_to_csv(working_condition,fault_class,out)

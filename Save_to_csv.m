function [] = Save_to_csv(fault_class,out)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

time = out.tout;
Im = out.Im;
Wm= out.Wm;

    Fault_type = repmat({fault_class}, length(time), 1);
    %%
    FDI_tab = table(time,Im,Wm,Fault_type);
    writetable(FDI_tab,sprintf('DC_motor_sensor_data\\%s_fault.csv', fault_class),'Delimiter',',','QuoteStrings',true)

    %% Monitor Plot
close all

subplot(1,2,1)
title('Im')
plot(time,Im)
subplot(1,2,2)
title('Wm')
plot(time,Wm)
sgtitle(sprintf('Fault Introduced - %s ', fault_class))
end


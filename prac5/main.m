%% 
% Joël Meyer, 10003539
% Lucas van Berkel, 10747958
% EZ-diffusion

clear all;

Pc = 0.9;
MRT = 100;
VRT =  1000;

[v,a,Ter] = EZdiffusionfit(Pc, VRT, MRT);

%%
PcD = zeros(10,4);
VRTD = zeros(10,4);
MRTD = zeros(10,4);
for i=1:10
    factor = i/10;
    [vP,aP,TerP] = EZdiffusionfit(Pc*factor, VRT, MRT);
    [vV,aV,TerV] = EZdiffusionfit(Pc, VRT*factor, MRT);
    [vM,aM,TerM] = EZdiffusionfit(Pc, VRT, MRT*factor);
    PcD(i,:) = [factor, vP, aP, TerP];
    VRTD(i,:) = [factor, vV, aV, TerV];
    MRTD(i,:) = [factor, vM, aM, TerM];
end
figure;
hold on;
title('Variance over v')
ylabel('Amount of v')
xlabel('factor times startvalue(=Pc:0.9,MRT:100,VRT:1000)')
plot(PcD(:,1),[PcD(:,2),VRTD(:,2),MRTD(:,2)]);
legend({'Pc' 'VRT' 'MRT'})
hold off;

figure;
hold on;
title('Variance over a')
ylabel('Amount of a')
xlabel('factor times startvalue(=Pc:0.9,MRT:100,VRT:1000)')
plot(PcD(:,1),[PcD(:,3),VRTD(:,3),MRTD(:,3)]);
legend({'Pc' 'VRT' 'MRT'})
hold off;
%%


figure;
hold on;
title('Variance over Ter')
ylabel('Amount of Ter')
xlabel('factor times startvalue(=Pc:0.9,MRT:100,VRT:1000)')
plot(PcD(:,1),[PcD(:,4),VRTD(:,4),MRTD(:,4)]);
legend({'Pc' 'VRT' 'MRT'})
hold off;
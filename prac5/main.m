%% 
% Joël Meyer, 10003539
% Lucas van Berkel, 10747958
% EZ-diffusion

clear;

Pc = 0.9;
MRT = 100;
VRT =  1000;

[v,a,Ter] = EZdiffusionfit(Pc, VRT, MRT);

disp(' ')
str = strcat('v is: ',num2str(v));
disp(str)
str = strcat('a is: ',num2str(a));
disp(str)
str = strcat('Ter is: ',num2str(Ter));
disp(str)

%% Assignment 2
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

figure;
hold on;
title('Variance over Ter')
ylabel('Amount of Ter')
xlabel('factor times startvalue(=Pc:0.9,MRT:100,VRT:1000)')
plot(PcD(:,1),[PcD(:,4),VRTD(:,4),MRTD(:,4)]);
legend({'Pc' 'VRT' 'MRT'})
hold off;
%% Assignment 3
clear;
dat = readdata ( 'data1.txt' );
correct = dat(:,1);
rt = dat(:,2);
[y1,x1] = ksdensity(rt(correct==0)) ;
[y2,x2] = ksdensity(rt(correct==1)) ;
plot(x1,y1,'k',x2,y2,'r');

Pc = length(find(correct))/length(correct);
MRT = mean(rt);
VRT = var(rt);

[v, a , Ter] = EZdiffusionfit(Pc, VRT, MRT);

disp(' ')
str = strcat('v is: ',num2str(v));
disp(str)
str = strcat('a is: ',num2str(a));
disp(str)
str = strcat('Ter is: ',num2str(Ter));
disp(str)

%% Assignment 4
dat = readdata('data2.txt');
correct = dat(:,1);
rt = dat(:,2);
[y1,x1] = ksdensity(rt(correct==0)) ;
[y2,x2] = ksdensity(rt(correct==1)) ;
plot(x1,y1,'k',x2,y2,'r');

Pc = length(find(correct))/length(correct);
MRT = mean(rt);
VRT = var(rt);

[v, a , Ter] = EZdiffusionfit(Pc, VRT, MRT);

disp(' ')
str = strcat('v is: ',num2str(v));
disp(str)
str = strcat('a is: ',num2str(a));
disp(str)
str = strcat('Ter is: ',num2str(Ter));
disp(str)
%% Assignment 5
clear;

loadBrysbaert();
X = struct2table(d);
X = table2array(X(:,[8 10]));
%%
correct = X(:,1);
rt = X(:,2);

[y1,x1] = ksdensity(rt(correct==0)) ;
[y2,x2] = ksdensity(rt(correct==1)) ;
plot(x1,y1,'k',x2,y2,'r');

Pc = length(find(correct))/length(correct);
MRT = mean(rt);
VRT = var(rt);

[v, a , Ter] = EZdiffusionfit(Pc, VRT, MRT);

disp(' ')
str = strcat('v is: ',num2str(v));
disp(str)
str = strcat('a is: ',num2str(a));
disp(str)
str = strcat('Ter is: ',num2str(Ter));
disp(str)

%% Assignment 6.1
clear;

rng(1310);
a=2;
v=1;
N=500;
Ter = .75;
[x,rt]=simdiff(N,a,v,Ter);

[y1,x1] = ksdensity(rt(x==0)) ;
[y2,x2] = ksdensity(rt(x==1)) ;
plot(x1,y1,'k',x2,y2,'r');

%% Assignment 6.2
clear;

rng(1310);
a = 1;
v = 2;
N= 500;
Ter =  0.5;
[x,rt]=simdiff(N,a,v,Ter);


rtC = rt(x==1);
rtI = rt(x==0);

y = zeros(1, length(rtC));
for i=1:length(rtC)
   y(i) = log(ddiff(rtC(i), 1, a, v, Ter));
end

sum(y)

y = zeros(1, length(rtI));
for i=1:length(rtI)
    y(i) = log(ddiff(rtI(i), 0, a, v, Ter));
end

sum(y)
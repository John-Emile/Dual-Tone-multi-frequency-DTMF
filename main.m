clc;
clear all;
close all;

%% Initialize variables
x_t = []; 
x_tg = []; %guard band added 
Fs = 8000; %Sampling frequency = 800Hz
% T = 1/8000 sec/sample
% 1/8000 ---> 1
% Time needed ---> N
N = 800;%Time domain signal of 100ms
Ng = 160; %Guard band of 20ms
silence = zeros(1,Ng);
phoneNum = '01284299877';
for i=1:length(phoneNum)
    x_t = [x_t Sym2TT(phoneNum(i))];
end

%% Plotting signal amplitude with time
%Range of time axis [0 to length(phone_num) with step length(x_t)]
t = linspace(0,length(phoneNum),length(x_t));
figure(1)
plot (t,x_t)
title ('Input Signal')
xlabel('Time(s)')
ylabel('Amplitude')

%% Adding guard band of 20ms and plot it with time
for i=1:length(phoneNum)
x_tg = [x_tg Sym2TT(phoneNum(i)) silence]; %create gap between digits
end
figure(2)
title ('Input Signal with guard band of 20ms')
xlabel('Time(s)')
ylabel('Amplitude')
tg = linspace(0,length(phoneNum),length(x_tg));
plot(tg,x_tg)




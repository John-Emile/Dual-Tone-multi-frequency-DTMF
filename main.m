clc;
clear all;
close all;

%% Initialize variables
x_tng = []; %no guard band 
x_t = []; %guard band added 
Fs = 8000; %Sampling frequency = 800Hz
% T = 1/8000 sec/sample
% 1/8000 ---> 1
% Time needed ---> N
N = 800;%Time domain signal of 100ms
Ng = 160; %Guard band of 20ms
silence = zeros(1,Ng);
phoneNum = '01284299877';
for i=1:length(phoneNum)
    x_tng = [x_tng Sym2TT(phoneNum(i))];
end

%% Plotting signal amplitude with time
%Range of time axis [0 to length(phone_num) with step length(x_t)]
time = linspace(0,length(phoneNum),length(x_tng));
figure(1)
plot (time,x_tng)
title ('Input Signal')
xlabel('Time(s)')
ylabel('Amplitude')

%% Adding guard band of 20ms and plot it with time
for i=1:length(phoneNum)
x_t = [x_t Sym2TT(phoneNum(i)) silence]; %create gap between digits
end
figure(2)
title ('Input Signal with guard band of 20ms')
xlabel('Time(s)')
ylabel('Amplitude')
t = linspace(0,length(phoneNum),length(x_t));
plot(t,x_t)

%% Making white additive guassian noise with variance = 0.1 and mean =0
var = 1; %variance of additive white guassian noise
noise = sqrt(var)*randn(size(t));
y_t = x_t + noise;
figure(3)
title ('AGWN + Signal')
xlabel('Time(s)')
ylabel('Amplitude')
plot(t,y_t)

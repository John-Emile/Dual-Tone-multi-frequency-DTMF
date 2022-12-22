clc;
clear all;
close all;

x_t = []; 
Fs = 8000; %Sampling frequency = 800Hz
% T = 1/8000 sec/sample
% 1/8000 ---> 1
% 100ms  ---> N
N = 800; 

phoneNum = '01284299877';
for i=1:length(phoneNum)
    x_t = [x_t Sym2TT(phoneNum(i))];
end

%Range of time axis [0 to length(phone_num) with step length(x_t)]
t = linspace(0,length(phoneNum),length(x_t));
plot (t,x_t)
title ('input signal')
xlabel('Time(s)')
ylabel('Amplitude')

clc;
clear all;
close all;

x_t = [];
Fs = 8000;
phone_num = '01284299877';
for i=1:length(phone_num)
    x_t = [x_t Sym2TT(phone_num(i))];
end

t = linspace(0,0.12*length(phone_num),length(x_t));
plot (t,x_t)
title ('input signal')
xlabel('Time')
ylabel('Amp')
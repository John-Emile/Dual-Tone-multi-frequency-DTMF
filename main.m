clc;
clear all;
close all;

%% Initialize variables
x_tng = []; %no guard band 
x_t = []; %guard band added 
Fs = 8000; %Sampling frequency = 8000 samples/sec
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
stepLength = length(phoneNum)*(N/Fs);
time = linspace(0,stepLength,length(x_tng));

%Plotting
figure(1)
plot (time,x_tng)
title ('Input Signal')
xlabel('Time(s)')
ylabel('Amplitude')

%% Adding guard band of 20ms and plot it with time
for i=1:length(phoneNum)
x_t = [x_t Sym2TT(phoneNum(i)) silence]; %create gap between digits
end
stepLength = length(phoneNum)*((N+Ng)/Fs);
t = linspace(0,stepLength,length(x_t));

%Plotting
figure(2)
plot(t,x_t)
title ('Input Signal with guard band of 20ms')
xlabel('Time(s)')
ylabel('Amplitude')

%% Making white additive guassian noise with variance = 0.1 and mean =0
var = 1; %variance of additive white guassian noise
noise = sqrt(var)*randn(size(t));
y_t = x_t + noise;

%plotting
figure(3)
plot(t,x_t)
title ('AGWN + Signal')
xlabel('Time(s)')
ylabel('Amplitude')

%% Saving the audio of my number
audiowrite('myNumber.wav',x_t,Fs);
audiowrite('myNumberNoiseAdded.wav',y_t,Fs);

%% obtain the spectrum Y(F) of the signal y(t) and plotting it
f = (-0.5+1/length(x_t):1/length(x_t):0.5)*Fs;

%Divide by Fs to normalize it & use abs to draw magnitude only
Y_F = abs(fftshift(fft(x_t))/Fs); 
y_db = 20.*log10(Y_F);
%Plotting
figure(4)
plot(f,Y_F)
title ('X(F) magnitude')
xlabel('Frequency(Hz)')
ylabel('Amplitude')
axis([600 1700 0 0.3]);


%Plotting
figure(5)
plot(f,y_db)
title ('X(F) in dB')
xlabel('Frequency(Hz)')
ylabel('Amplitude(dB)')
axis([600 1700 -100 -10]);


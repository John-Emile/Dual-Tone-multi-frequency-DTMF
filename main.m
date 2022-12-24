clc;
clear all;
close all;

%% Initialize variables
x_tng = []; %no guard band 
x_t = []; %guard band added 
Fs = 8000; %Sampling frequency = 8000 samples/sec
figCounter =1;

%% Get input from user

% Get phone number from user
phoneNum = input('Dial a Phone Number: ' , 's'); 

while length(phoneNum) <= 4
disp('Invalid number, Enter at least 5 numbers');
phoneNum = input('Dial a Phone Number: ' , 's');     
end

% Ts = 1/8000 sec/sample
% 1/8000 ---> 1
% Time needed ---> N

%Get time of number in time domain
timeNeeded = input('Enter time domain signal in ms: ' , 's');
N = str2num(timeNeeded)*Fs*1e-3;

%Get time of guard band
timeNeeded2 = input('Enter guard band time in ms: ' , 's');
Ng = str2num(timeNeeded2)*Fs*1e-3;


% %Implement zeros for guard band
silence = zeros(1,Ng);



%% Plotting signal amplitude with time (Not Needed)
% 
% for i=1:length(phoneNum)
%     x_tng = [x_tng Sym2TT(phoneNum(i))];
% end
% %Range of time axis [0 to length(phone_num) with step length(x_t)]
% stepLength = length(phoneNum)*(N/Fs);
% time = linspace(0,stepLength,length(x_tng));
% 
% %Plotting
% figure(figCounter)
% figCounter = figCounter+1;
% plot (time,x_tng)
% title ('Input Signal')
% xlabel('Time(s)')
% ylabel('Amplitude')

%% Adding guard band of 20ms and plot it with time
for i=1:length(phoneNum)
x_t = [x_t Sym2TT(phoneNum(i)) silence]; %create gap between digits
end
stepLength = length(phoneNum)*((N+Ng)/Fs);
t = linspace(0,stepLength,length(x_t));

%Plotting
figure(figCounter)
figCounter = figCounter+1;
plot(t,x_t)
title ('Input Signal with guard band of 20ms')
xlabel('Time(s)')
ylabel('Amplitude')

%% Making white additive guassian noise with variance = 0.1 and mean =0
var = 1; %variance of additive white guassian noise
%noise = sqrt(var)*randn(size(t));
noise = 0.1*randn(var,length(x_t)); %0.1 to minimize noise power
y_t = x_t + noise;

%plotting
figure(figCounter)
figCounter = figCounter+1;
plot(t,y_t) 
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

%Plotting spectrum magnitude
figure(figCounter)
figCounter = figCounter+1;
plot(f,Y_F)
title ('X(F) magnitude')
xlabel('Frequency(Hz)')
ylabel('Amplitude')
axis([600 1700 0 0.3]);

%Plotting spectrum magnitude in dB
figure(figCounter)
figCounter = figCounter+1;
plot(f,y_db)
title ('X(F) in dB')
xlabel('Frequency(Hz)')
ylabel('Amplitude(dB)')
axis([600 1700 -100 -10]);

%% Implementing the boxcar spectrogram

windowSizes = {16 64 256 1024 4096};
for i=1:length(windowSizes)
    windowLen = windowSizes{i};
    nFloor = floor(windowLen/2);
    fftSize = 2^14;
    figure (figCounter)
    figCounter = figCounter + 1;
    spectrogram(x_t,rectwin(windowLen),nFloor,fftSize,Fs);
    title(sprintf('Spectrogram of %i rectwin \n',windowSizes{i}));
end

%% Implementing the blackman spectrogram

windowSizes = {16 64 256 1024 4096};
for i=1:length(windowSizes)
    windowLen = windowSizes{i};
    nFloor = floor(windowLen/2);
    fftSize = 2^14;
    figure (figCounter)
    figCounter = figCounter+1;
    spectrogram(x_t,blackman(windowLen),nFloor,fftSize,Fs);
    title(sprintf('Spectrogram of %i blackman \n',windowSizes{i}));
end

    
%% Decoding x(t) to obtain the phone number
f = [697 770 852 941 1209 1336 1477 1633]; %All possible frequencies
freqIndices = round(f/Fs*(N+Ng)) + 1;
j=0;    %Counter to adjust all samples
decodedNum = [];
for i=1:length(phoneNum) 
    y_nt = y_t(((j*960)+i):(i*961));
    j = j+1;
    
    dft_data = goertzel(y_nt,freqIndices); 
    figure (figCounter)
    subplot (6,2,i)
    stem(f,abs(dft_data))
    title(sprintf('Number %i \n',i));

    dft_data_abs = abs(dft_data);
    [val, idx1] = max(abs(dft_data)); 
    dft_data_abs(idx1) = 0;
    [val, idx2] = max(abs(dft_data_abs)); 
    dft_data_abs(idx2) = 0;
    decodedNum = [decodedNum decode(f(idx1),f(idx2))];
end
disp('The entered number is : ');
disp(decodedNum);

clc; clear; close all;

fs = 1000;  % Sampling frequency (Hz)
T = 2;      % Duration (seconds)
t = 0:1/fs:T-1/fs;  % Time vector

% Stationary Signal: Gaussian White Noise
stationary_signal = randn(size(t));

% Non-Stationary Signal: Chirp signal (Frequency increases over time)
f0 = 5;  % Initial frequency (Hz)
f1 = 50; % Final frequency (Hz)
nonstationary_signal = chirp(t, f0, T, f1) + 0.2*randn(size(t)); % Chirp + noise

% Plot the signals
figure;
subplot(2,1,1);
plot(t, stationary_signal);
title('Stationary Signal: White Noise');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(2,1,2);
plot(t, nonstationary_signal);
title('Non-Stationary Signal: Chirp with Time-Varying Frequency');
xlabel('Time (s)'); ylabel('Amplitude');

% Spectrograms for time-frequency analysis: frequency changes with time for non stat
% short term fourier transform : frequency at a particular point, and colour shows you intensity 
% power efficiency : which essentially shows you the power of the signal 
% at a particular frequency at a particular time
figure;
subplot(2,1,1);
spectrogram(stationary_signal,256,250,256,fs,'yaxis');
title('Spectrogram of Stationary Signal');

subplot(2,1,2);
spectrogram(nonstationary_signal,256,250,256,fs,'yaxis');
title('Spectrogram of Non-Stationary Signal');

%%% Extra, if you want to see the analysis of the spectogram (not required for the course.)

%Interpreting a Spectrogram
% - Horizontal lines → Constant frequency tones.
% - Vertical stripes → Sudden bursts of energy.
% - Slanted curves → Changing frequency over time (e.g., chirp signals).
% - Dense regions → High-energy areas in specific time-frequency bands.

% Stationary Signal (White Noise)
% - Spectrogram looks random with uniform energy across frequencies.
% - No visible pattern since all frequencies are equally present over time., colour remains consistent 
% - TIME INDEPENDENT SIGNAL BEHAVIOUR

% Non-Stationary Signal (Chirp Signal)
% - Frequency increases gradually over time → Diagonal pattern in spectrogram.: frequency content changes over time 
% - certain frequencies gain more energy sometimes!, we see how the colour changes from green upto yellow 
% - TIME DEPENDENT SIGNAL BEHAVIOUR
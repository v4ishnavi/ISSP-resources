% illustrating the difference between sss and wss signals
% Strict sense stationary: mean, covar and joint pdfs dont change with time (all statistical properties)
% Wide sense stationary: mean and covar dont change with time (only first and second order statistics)
clc; clear; close all;

% Parameters
fs = 1000;          % Sampling frequency (Hz)
T = 2;              % Duration (seconds)
t = 0:1/fs:T-1/fs;  % Time vector

% 1. Strict-Sense Stationary (SSS) Signal: White Gaussian Noise
sss_signal = randn(size(t));

% 2. Wide-Sense Stationary (WSS) Signal: Sinusoid with Random Phase
A = 1;        
f = 5;         
w = 2*pi*f; 
phi = 2*pi*rand - pi; 
wss_signal = A * sin(w*t + phi);

% Plot the signals
figure;
subplot(2,1,1);
plot(t, sss_signal);
title('Strict-Sense Stationary (SSS) Signal: White Gaussian Noise');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t, wss_signal);
title('Wide-Sense Stationary (WSS) Signal: Sinusoid with Random Phase');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Compute and plot the mean and autocorrelation functions
% 1. SSS Signal
mean_sss = mean(sss_signal);
var_sss = var(sss_signal);
[acf_sss, lags_sss] = xcorr(sss_signal, 'biased');
lags_sss = lags_sss / fs; % Convert lags to time

% 2. WSS Signal
mean_wss = mean(wss_signal);
var_wss = var(wss_signal);
[acf_wss, lags_wss] = xcorr(wss_signal, 'biased');
lags_wss = lags_wss / fs; % Convert lags to time

% Plot mean and autocorrelation functions
figure;
subplot(2,2,1);
plot(t, mean_sss * ones(size(t)));
title('Mean of SSS Signal');
xlabel('Time (s)');
ylabel('Mean Amplitude');
grid on;

subplot(2,2,2);
plot(lags_sss, acf_sss);
title('Autocorrelation of SSS Signal');
xlabel('Lag (s)');
ylabel('Autocorrelation');
grid on;

subplot(2,2,3);
plot(t, mean_wss * ones(size(t)));
title('Mean of WSS Signal');
xlabel('Time (s)');
ylabel('Mean Amplitude');
grid on;

subplot(2,2,4);
plot(lags_wss, acf_wss);
title('Autocorrelation of WSS Signal');
xlabel('Lag (s)');
ylabel('Autocorrelation');
grid on;

lags = [0, 0.15, 0.37, 0.75]; % Different time lags in seconds

% Prepare figure
figure('Position', [100, 100, 1500, 800]);
signals = {sss_signal, wss_signal};
signal_names = {'Stationary (White Noise)', 'Non-Stationary (Sinusoid)'};

for signal_idx = 1:2
    current_signal = signals{signal_idx};
    
    % Plot PDFs for different lags
    for lag_idx = 1:length(lags)
        lag = lags(lag_idx);
        lag_samples = round(lag * fs);
        
        % Extract signal segments
        if lag_samples == 0
            segment1 = current_signal(1:end-1);
            segment2 = current_signal(2:end);
        else
            segment1 = current_signal(1:end-lag_samples);
            segment2 = current_signal(1+lag_samples:end);
        end
        
        % Subplot
        subplot(2, length(lags), (signal_idx-1)*length(lags) + lag_idx);
        
        % Kernel Density Estimation
        [f1, xi1] = ksdensity(segment1);
        [f2, xi2] = ksdensity(segment2);
        
        % Plot PDFs
        plot(xi1, f1, 'b', 'LineWidth', 2);
        hold on;
        plot(xi2, f2, 'r--', 'LineWidth', 2);
        
        title(sprintf('%s (Lag = %0.1f s)', signal_names{signal_idx}, lag));
        xlabel('Amplitude');
        ylabel('Density');
        legend('Segment 1', 'Segment 2');
        grid on;
    end
end

sgtitle('PDF Comparison for Different Time Lags', 'FontSize', 16);
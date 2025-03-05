clc; clear; close all;

% Parameters
n_realizations = 5;  % Number of realizations
n_samples = 100;     % Number of time samples
t = 0:n_samples-1;   % Time vector

% Generate random process (e.g., Gaussian noise)
X = randn(n_realizations, n_samples);

% Plot multiple realizations
figure;
hold on;
for i = 1:n_realizations
    plot(t, X(i, :), 'DisplayName', ['Realization ' num2str(i)]);
end
xlabel('Time');
ylabel('Amplitude');
title('Multiple Realizations of a Random Process');
legend show;
grid on;

% Compute and plot mean and covariance
mean_X = mean(X, 1);
cov_X = cov(X);

figure;
subplot(2, 1, 1);
plot(t, mean_X);
xlabel('Time');
ylabel('Mean Amplitude');
title('Mean of the Random Process');
grid on;

subplot(2, 1, 2);
imagesc(cov_X);
colorbar;
xlabel('Time');
ylabel('Time');
title('Covariance Matrix of the Random Process');
grid on;


n_realizations_plot = 2; 

maxLag = 20;

for i = 1:n_realizations_plot
    
    [acf, lags] = xcorr(X(i, :), maxLag, 'biased'); % acf -> autocorrelation function, lags -> lags
    
    mean_adjusted = X(i, :) - mean(X(i, :));
    [acovf, lags_cov] = xcorr(mean_adjusted, maxLag, 'biased');
    
    % Normalize autocorrelation
    acf = acf / acf(maxLag + 1); 
    
    % Plot autocorrelation
    figure;
    subplot(2, 1, 1);
    stem(lags, acf, 'filled');
    xlabel('Lag');
    ylabel('Autocorrelation');
    title(['Autocorrelation of Realization ' num2str(i)]);
    grid on;
    
    % Plot autocovariance
    subplot(2, 1, 2);
    stem(lags_cov, acovf, 'filled');
    xlabel('Lag');
    ylabel('Autocovariance');
    title(['Autocovariance of Realization ' num2str(i)]);
    grid on;
end

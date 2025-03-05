% lets look at an example  
clc; clear; close all;

% A*sin(w*t + phi) where phi ~ U[-pi, pi] where U is uniform distribution
A = 1;          % Amplitude
w = 2*pi*1;     % Frequency (rad/s)
% uniform distribution for phi..
phi = 2*pi*rand - pi; % Phase (randomized)
% signal with time 
fs = 1000;  % Sampling frequency (Hz)
T = 2;      % Duration (seconds)
t = 0:1/fs:T-1/fs;  % Time vector
% signal
X = A*sin(w*t + phi);

% Plot the signal
figure;
plot(t, X);
title('Sinusoidal Signal with Random Phase');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% ------------------recommended to check the math from your notes :p ------------------------

% mean function mu[t] = E[X(t)] = E[A*sin(w*t + phi)] = integral bw pi, -pi g(alpha)*f(alpha) d(alpha)
% calculate the mean using integral
integrand = @(alpha) A * sin(w * t + alpha) / (2 * pi);
mu = integral(@(alpha) integrand(alpha), -pi, pi, 'ArrayValued', true);
% disp(['Theoretical Mean: ' num2str(mu)]);
% mu = A*sin(w*t) * 1/(2*pi) * integral bw pi, -pi 1 d(alpha) = A*sin(w*t) * 1/(2*pi) * 2*pi = A*sin(w*t)
% mu = A*sin(w*t) = A*sin(2*pi*1*t) = A*sin(2*pi*t) = 0
% mu = 0
% mean is zero, as the signal is symmetric about the x-axis

% autocorrelation X(n1)*X(n2) = 
% E[X(n1)*X(n2)] = E[A*sin(w*n1 + phi)*A*sin(w*n2 + phi)] =
%  E[A^2*sin(w*n1 + phi)*sin(w*n2 + phi)] = 
%  A^2 * E[sin(w*n1 + phi)*sin(w*n2 + phi)] =
%  A^2 * integral bw pi, -pi sin(w*n1 + alpha)*sin(w*n2 + alpha) * 1/(2*pi) d(alpha)
%  A^2 * 1/(2*pi) * integral bw pi, -pi sin(w*n1 + alpha)*sin(w*n2 + alpha) d(alpha)
%  A^2 * 1/(2*pi) * integral bw pi, -pi 1/2 * (cos(w*(n1-n2) - cos(w*(n1+n2))) d(alpha)
t1 = 1; 
t2 = 1.5;
 % finding autocorr between these points ....
integrand_autocorr = @(alpha) A^2 * sin(w * t1 + alpha) .* sin(w * t2 + alpha) * (1 / (2 * pi));
autocorr_numeric = integral(integrand_autocorr, -pi, pi);
disp(['Theoretical Autocorrelation: ' num2str(autocorr_numeric)]);

% 0.5* A^2 cos(w(n1 - n2))
% INFERENCE: AUTOCORRELATION IS A FUNCTION OF THE TIME DIFFERENCE BETWEEN THE TWO POINTS : 
% wide sense stationary!
% plot
figure;
plot(t, mu);
title('Mean Function of the Random Process');
ylim([-1 1]);
xlabel('Time (s)');
ylabel('Mean Amplitude');
grid on;

% for different time differences plot autocorr.... (lets make this easy for ourselves shall we)
tau = -T:1/fs:T;
R_X_theoretical = 0.5 * A^2 * cos(w * tau);
figure;
plot(tau, R_X_theoretical, 'r', 'LineWidth', 1.5);
title('Theoretical Autocorrelation Function');
xlabel('Time Lag \tau (s)');
ylabel('Autocorrelation R_X(\tau)');
grid on;

% okay, let us emperically check :D 

% MEAN 
% Number of realizations
numRealizations = 10000;  % CHANGE THIS VALUE AND CHECK! 
X_realizations = zeros(numRealizations, length(t));

for i = 1:numRealizations
    phi = 2*pi*rand - pi;
    X_realizations(i, :) = A * sin(w*t + phi);
end

mu_sample = mean(X_realizations, 1);

figure;
plot(t, mu_sample);
title('Sample Mean Function of the Random Process');
ylim([-1 1]);
xlabel('Time (s)');
ylabel('Mean Amplitude');
grid on;

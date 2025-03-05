clc; clear; close all;

n = 1000; % Number of samples
p = 0.3;  % Probability of success

% Generate Bernoulli random variable (0 or 1)
X = rand(n, 1) < p;

figure;
histogram(X, 'Normalization', 'probability');
xlabel('Value');
ylabel('Probability');
title('Discrete Random Variable (Bernoulli Distribution)');
grid on;

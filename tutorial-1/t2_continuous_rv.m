clc; clear; close all;

mu = 0;    % Mean
sigma = 1; % Standard deviation
n = 1000000;  % can change values of n....

X = mu + sigma * randn(n, 1); %gaussian. here values range from -inf to +inf

figure;
histogram(X, 'Normalization', 'pdf');
xlabel('Value');
ylabel('Probability Density');
title('Continuous Random Variable (Gaussian Distribution)');
grid on;

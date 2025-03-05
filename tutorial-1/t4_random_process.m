clc; clear; close all;

n_realizations = 5; %(X1(w1,t), X2(w2,t), ...)
n_samples = 100;    % Number of time samples
t = 0:n_samples-1;  % Time vector

% generating the random process....
X = randn(n_realizations, n_samples);


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

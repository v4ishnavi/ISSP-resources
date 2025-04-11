clc, clearvars, close all; 

% lets use the linear predictor from c9_1 
N = 500; 
no_realizations = 100; 

% mulist= [0.05, 0.01];
p = 2; % filter order 
a = [1.2728, -0.81];
% a = [0.1, 0.8]; 
sigma_v2 = 0.25; 
MSE = zeros(N,no_realizations);
w_total = zeros(p,no_realizations);
cvals = [0.01, 0.1, 1, 10, 100];
for cidx = 1: length(cvals)
    c = cvals(cidx)
for realization = 1:no_realizations
    v = sqrt(sigma_v2) * randn(N, 1);
    x = zeros(N, 1);
    x(1:2) = randn(2,1);
    for n = 3:N
        x(n) = a(1)*x(n-1) + a(2)*x(n-2) + v(n);
    end

    w = zeros(p, 1);

    for n = p+1:N
        x_vec = x(n-1:-1:n-p);
        d = x(n);
        y = w' * x_vec;
        e = d - y;
        mu_n = 1/(c+n^2);
        w = w + mu_n * e * x_vec;
        MSE(n) = MSE(n) + e^2;
    end
end

% Average MSE over realizations
MSE_avg = mean(MSE, 2);


% Plot MSE
figure;
plot(10*log10(MSE_avg), 'LineWidth', 1.5);
title(['Variable Step-Size LMS (\mu(n) = 1/(c + n), c = ' num2str(c) ')']);
xlabel('Iteration (n)');
ylabel('MSE (dB)');
grid on;
end
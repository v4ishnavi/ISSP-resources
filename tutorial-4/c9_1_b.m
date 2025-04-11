clc, clearvars, close all; 
% part b: implement lms filter 
N = 500; 
no_realizations = 100; 

mulist= [0.05, 0.01];
p = 2; % filter order 
a = [1.2728, -0.81];
% a = [0.1, 0.8]; 
sigma_v2 = 0.25; 

for muidx  = 1: length(mulist)
    mu = mulist(muidx);
    MSE = zeros(N, no_realizations);

    for realization = 1: no_realizations
        v = sqrt(sigma_v2)*randn(N, 1); % noise
        x = zeros(N, 1); % input signal

        x(1:2) = randn(2,1); % random init values, could be zeros too 
        for n = 3: N
            x(n) = a(1)*x(n-1) + a(2)*x(n-2) + v(n); % AR process 
        end
        w = zeros(p, 1); % filter weights

        for n = p+1:N
            x_vec = x(n-1:-1:n-p);
            d = x(n);
            y = w' * x_vec; 
            e = d - y; 
            w = w + mu*e*x_vec; % update weights LMS 
            MSE(n, realization) = e^2; % store the error
        end
    end
    MSE_avg = mean(MSE, 2); % average over realizations
    figure;
        plot(10*log10(MSE_avg), 'LineWidth', 1.5);
        title(['Ensemble-Averaged Learning Curve, \mu = ', num2str(mu)]);
        xlabel('Iteration (n)');
        ylabel('MSE (dB)');
        grid on;
end




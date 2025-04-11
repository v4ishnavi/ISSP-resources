clc, clearvars, close all;

N = 500; 
no_realizations = 100; 

mulist= [0.05, 0.01];
p = 2; % filter order 
a = [1.2728, -0.81];
% a = [0.1, 0.8]; 
sigma_v2 = 0.25; 

for mu_idx = 1:length(mulist)
    mu = mulist(mu_idx);
    w_vals = zeros(p, no_realizations);  % To accumulate final weights

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
            w = w + mu * e * x_vec;
        end

        w_vals(:, realization) = w;  % Store final weights for this realization
    end

    % Average final weights across realizations
    w_avg = mean(w_vals, 2);

    fprintf('\nAverage steady-state LMS weights for mu = %.3f:\n', mu);
    disp(w_avg);
end

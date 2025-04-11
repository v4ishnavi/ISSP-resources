clc, clearvars, close all; 
% part a : calculate the convergence lms bound 
a1 = -0.1;
a2 = -0.8; 
sigma_v2 = 0.25; 


% solve the yule walker eqns manually 
r0_val  = 0.50/0.54;
r1_val = 0.5*r0_val;
r2_val = 0.8*r0_val + 0.2*r1_val;

Rx = [r0_val, r1_val; r1_val, r0_val];
lambda = eig(Rx);
lambda_max = max(lambda);

mu_bound = 2/lambda_max;
disp(mu_bound)


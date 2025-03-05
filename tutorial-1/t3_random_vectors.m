clc; clear; close all;

mu = [0 0];          % Mean vector
Sigma = [1 0.5; 0.5 1]; % Covariance matrix
n = 1000;
X = mvnrnd(mu, Sigma, n); %bivariate normal random vector 

% Plot joint histogram, this shows us the joint distribution of the two random variables
figure;
hist3(X, 'CdataMode', 'auto', 'FaceColor', 'interp');
xlabel('X1');
ylabel('X2');
zlabel('Frequency');
title('Joint Histogram of Bivariate Normal Random Vectors');
grid on;

% Plot joint PDF
[X1, X2] = meshgrid(linspace(min(X(:,1)), max(X(:,1)), 50), linspace(min(X(:,2)), max(X(:,2)), 50));
F = mvncdf([X1(:) X2(:)], mu, Sigma);
F = reshape(F, size(X1));

figure;
surf(X1, X2, F);
xlabel('X1');
ylabel('X2');
zlabel('CDF');
title('Joint CDF of Bivariate Normal Distribution');
grid on;

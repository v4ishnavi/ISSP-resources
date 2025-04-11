clc, clearvars, close all
%1000 samples  0 mean, 1 variance 
% part a
% y = wgn(1000, 1, 1, 'linear');
y = randn(1000, 1);
y = [zeros(100,1); y]; %100 zeros at the start

auto_corr = zeros(100,1);% init

for k = 1:100
    
    sum = 0;
    for i = k:(1000+k-1)
        sum = sum + y(i)*y(i-k+1);
    end
    auto_corr(k) = sum/1000;
end
true_auto_corr = zeros(100,1);
true_auto_corr(1) = 1;

figure;
subplot(2,1,1);
stem(auto_corr);
xlabel("k");
ylabel("autocorr values")
title("Estimated autocorrelation")

subplot(2,1,2);
stem(true_auto_corr);
xlabel("k");
ylabel("true autocorr value")
title(" True autocorrelation")

%part c 
% y_split = reshape(y, 110, 10);
auto_corr_new = zeros(100,1);
for k = 1:100
    sum_new_new = 0;
    for j = 1:10
        sum_new = 0;
        for i=1:100 %here the code is slightly diff since we start 
            %from j = 1 rather than j = 0. 
            sum_new = sum_new + y(i + 100*j)*y(i+100*j-k+1);
        end
        sum_new_new = sum_new_new + sum_new;
    end 
    auto_corr_new(k) = sum_new_new/1000;
end
figure;
subplot(2,1,1);
stem(auto_corr_new);
xlabel("k");
ylabel("autocorr values")
title("Estimated autocorrelation")

subplot(2,1,2);
stem(true_auto_corr);
xlabel("k");
ylabel("true autocorr value")
title(" True autocorrelation")

%Part d: 
% z = wgn(10000, 1, 1, 'linear');
z = randn(10000, 1);
z = [zeros(100,1); z];
auto_corr_z = zeros(100,1);
for k = 1:100
    sum = 0;
    for i = k:(10000+k-1) %after 1000 - k we have zeros
        sum = sum + z(i)*z(i-k+1);
    end
    auto_corr_z(k) = sum/10000;
end
figure;
subplot(2,1,1);
stem(auto_corr_z);
xlabel("k");
ylabel("autocorr values")
title("Estimated autocorrelation")

subplot(2,1,2);
stem(true_auto_corr);
xlabel("k");
ylabel("true autocorr value")
title(" True autocorrelation")


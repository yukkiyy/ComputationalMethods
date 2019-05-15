%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% CS 335 Assignment 3 Question 6 %%%%%%%%%
%%%%%%%%            Yao Yao (20304422)             %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clear all;
clc;

%% compute the Newton iterations give (K, P)

% define parameters 
Ks = 220:10:340;
Ps = [.15, .25, .40, .70, 1.24, 2.32, 4.0, 6.70, 10.10, 16.00, 22.31, 29.70, 38.];

% define result matrices
Ss = [];

% for each pair of K and P compute implied volatility
for i = 1:1:length(Ks)
        
        % print each strike price
        disp('strike price is')
        disp(Ks(i))
        
        % compute sigma for each piar of K and P 
        s = Implied_Volatility(Ks(i), Ps(i));
        Ss = [Ss s];
        
end 

% output result table
result = table(Ks', Ss');
result.Properties.VariableNames = {'Strikes','Implied_Volatilities'};
disp(result)

% plot result 
figure(1)
plot(Ks, Ss)
title('Implied Volatility VS Strike Price')
xlabel('Strike Price')
ylabel('Implied Volatility')
        

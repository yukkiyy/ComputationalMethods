%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  CS 335 Assignment 4  %%%%%%%%%%%%%%
%%%%%%%%%%%%%%             Question 4           %%%%%%%%%%%%%%
%%%%%%%%%%%%%%                Yao Yao             %%%%%%%%%%%%%%
%%%%%%%%%%%%%%              20304422           %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; 
clear all;
clc;

%% define input parameters
% values given
S0_1 = 15;
S0_2 = 15;
K = 15; 
sigma_1 = 0.15;
sigma_2 = 0.12;
r = 0.04;
rhos =  [-1:0.1:1];
rho = 0.4;
N = 250; 
T = 1.0; 
M = 128000;

%% compute V0 when rho = 0.4
V0 = MC_Rainbow(S0_1, S0_2, r, sigma_1, sigma_2, rho, K, T, M, N);
disp('Rainbow Value')
disp(V0)

%% plot results

% define a rainbow vector
V0s = [];

% loop over to get all option values
for i = 1: length(rhos)
    
    V0s(i) = MC_Rainbow(S0_1, S0_2, r, sigma_1, sigma_2, rhos(i), K, T, M, N);
    
end 

% plot rainbow values VS rhos

figure (6) 

plot (rhos, V0s)
xlabel('Correlations')
ylabel('Rainbow Values')    
title('Rainbow Values VS Correlations')


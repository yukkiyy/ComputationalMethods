%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  CS 335 Assignment 4  %%%%%%%%%%%%%%
%%%%%%%%%%%%%%      Question 1 Part a      %%%%%%%%%%%%%%
%%%%%%%%%%%%%%                Yao Yao             %%%%%%%%%%%%%%
%%%%%%%%%%%%%%              20304422           %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; 
clear all;
clc;

%% define parameters for Monte Carlo Simulations

% parameters given
sigma = 0.15;
r = 0.04;
T = 1.0; 
K = 100;
S0 = 100;
deltas = [10/250; 5/250; 2/250; 1/250];
Ms = [2000; 4000; 8000; 16000; 32000; 64000; 128000];

% define the output vector
V0s = []; 
SDs = [];

%% loop over all pairs to generate European Call using MC

% loop over deltas and number of simulations
for i = 1: length(deltas)
    
    for j = 1: length(Ms)
        
        [V0s(j,i), SDs(j,i) ] = EuropeanCall(S0, r, sigma, T, Ms(j), deltas(i), K);
        
    end
    
end 

%% compute exact price using matlab function

V_exact = blsprice(S0, K, r, T, sigma);

%% plot results

figure (1) 

subplot (2,2,1)
plot (Ms, V0s (:,1), Ms, ones(size(Ms))*V_exact)
title(' European Call ; delta = 10/250')

subplot (2,2,2)
plot (Ms, V0s (:,2), Ms, ones(size(Ms))*V_exact)
title(' European Call ; delta = 5/250')

subplot (2,2,3)
plot (Ms, V0s (:,3), Ms, ones(size(Ms))*V_exact)
title(' European Call ; delta = 2/250')

subplot (2,2,4)
plot (Ms, V0s (:,4), Ms, ones(size(Ms))*V_exact)
title(' European Call ; delta = 1/250')

%% compute table of 99% CI for delta = 1/ 250

% initialize the upper and lower bounds
lbs = zeros(length(Ms),1);
ubs = zeros(length(Ms),1);

% compute the lbs and ubs
for k = 1: length(Ms)
    
    lbs(k) = V0s(k,4) - 2.58*SDs(k, 4)/ sqrt(Ms(k));
    ubs(k) = V0s(k,4) + 2.58*SDs(k, 4)/ sqrt(Ms(k));
    
end 
    
% tabulate results

c_name = {'Mean', 'Lower bound', 'Upper bound'};
r_name = {'M = 2000', 'M = 4000', 'M= 8000', 'M = 16000', 'M = 32000', 'M = 64000', 'M = 128000'};

f = figure(2);
c_data = [V0s(:,4), lbs, ubs];
uitable(f, 'Data', c_data, 'Columnname', c_name, 'Rowname', r_name,'Position', [15 15 340 150]);



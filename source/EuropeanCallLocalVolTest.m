%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  CS 335 Assignment 4  %%%%%%%%%%%%%%
%%%%%%%%%%%%%%      Question 1 Part b      %%%%%%%%%%%%%%
%%%%%%%%%%%%%%                Yao Yao             %%%%%%%%%%%%%%
%%%%%%%%%%%%%%              20304422           %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; 
clear all;
clc;

%% define parameters for Monte Carlo Simulations

% parameters given
alpha = 1.5;
r = 0.04;
T = 1.0; 
Ks = linspace(80,120,20);
S0 = 100;
delta = 1/250;
M = 256000;
K = 100;

% define the output vector
V0s = []; 

% compute V0 when K = 100
 V0 = EuropeanCallLocalVol(S0, r, alpha, T, M, delta, K);

%% loop over all strikes to generate European Call using MC

% loop over strikes
for i = 1: length(Ks)
   
        [V0s(i)] = EuropeanCallLocalVol(S0, r, alpha, T, M, delta, Ks(i));
    
end 

%% compute implied volatility 
% initialize a vector for implied volatility 
sigmas = [];

% compute simplied volatility 
for k = 1: length(V0s)
    
    sigmas(k) = blsimpv(S0, Ks(k), r, T, V0s(k),1,0,[],true);
    
end 

%% plot results

figure (3) 

plot (Ks, sigmas)
xlabel('Strikes')
ylabel('Implied Volatility')    
title('Implied Volatility VS Strike Price')




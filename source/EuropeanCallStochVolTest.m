%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  CS 335 Assignment 4  %%%%%%%%%%%%%%
%%%%%%%%%%%%%%             Question 3           %%%%%%%%%%%%%%
%%%%%%%%%%%%%%                Yao Yao             %%%%%%%%%%%%%%
%%%%%%%%%%%%%%              20304422           %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; 
clear all;
clc;

%% define input parameters
% risk free rate
r = 0.02;
% initial variance
v_0 = 0.0283;
% long run variance
v_long = 0.0351;
% reversion to last variance
n = 0.3671;
% correlation 
rho = -0.7163;
% reversion to long run average
lamda = 1.3523;
% initial asset price
S0 = 100;
% strike
K = 100;
% expiry date
T = 1;
% number of time steps
N = 100;
% number of simulations 
M = 100000;
% a vector of strikes
Ks = linspace(80, 120, 20);
% a vector of expiries
Ts = linspace(1,10, 20);

%% compute European Call value 

V0 = EuropeanCallStochVol(S0, r, v_0, v_long, n, rho, lamda, T, M, N, K);
disp('European Call')
disp(V0)

%% generate a sequence of European Call values 

% initialize vectors 
V1s = [];
sigma1s = [];
V2s = [];
sigma2s = [];

for i = 1 : length(Ks)
    
    V1s(i) = EuropeanCallStochVol(S0, r, v_0, v_long, n, rho, lamda, T, M, N, Ks(i));
    sigma1s(i) = blsimpv(S0, Ks(i), r, T, V1s(i));
    
end 

for i = 1: length(Ts)
    
    V2s(i) = EuropeanCallStochVol(S0, r, v_0, v_long, n, rho, lamda, Ts(i), M, N, K);
    sigma2s(i) = blsimpv(S0, K, r, Ts(i), V2s(i)); 
    
end 


%% plot results

figure(7) 

subplot(1,2,1)
plot(Ks, sigma1s);
 title('Implied Volatility VS Strike Prices ')
 xlabel('Strikes')
 ylabel('Implied Volatility')
 
subplot(1,2,2)
plot(Ts, sigma2s);
 title('Implied Volatility VS Expiry Dates ')
 xlabel('Expiries')
 ylabel('Implied Volatility')
 

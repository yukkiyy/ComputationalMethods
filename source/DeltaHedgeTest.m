%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  CS 335 Assignment 4  %%%%%%%%%%%%%%
%%%%%%%%%%%%%%             Question 2           %%%%%%%%%%%%%%
%%%%%%%%%%%%%%                Yao Yao             %%%%%%%%%%%%%%
%%%%%%%%%%%%%%              20304422           %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; 
clear all;
clc;

%% define input parameters
% values given
sigma = 0.23;
r = 0.03;
T = 1;
K = 110;
S0 = 110;
mu = 0.08;
Ns = [100; 1000; 10000];

% RHEs vector
RHEs = zeros (3,1);

%% plot results

figure(4) 

for i = 1: length(Ns)
    
    [t, P, S, V, B, H] = DeltaHedge(sigma, r, T, K, S0, mu, Ns(i));
    RHEs(i) = exp(-r*T)*P(Ns(i)+1)/V(1);
    subplot(3,1,i)
    plot(t,S,t,B,t,H,t,P)
    title(['Delta Hedge with' num2str(Ns(i)) ' Rebalances'])
    
end 

%% tabulate RHEs

f = figure(5);
c_name = {'Relative Hedge Error'};
r_name = {'100 rebalances', '1000 rebalances', '10000 rebalances'};
uitable(f, 'Data', RHEs, 'Columnname', c_name, 'Rowname', r_name,'Position', [20 20 300 90]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% CS 335 Assignment 1 Question 7 (Yao Yao) %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%W%%%%%%%%%%%%%%%%%%%%%

clear;
clear all;

%% Generate a random walk on lattice

% define parameters
N_simu = 50000;
N = 500;
alpha = 0.07;
sigma = 0.15;
X_init = 0;
T = 2.0;

% compute X
X = Lattice(N_simu,N,alpha,sigma,T,X_init);

%% Plot density and overlay Normal 

% histogram
histogram_density(X,-1,1,50);
hold on;

% get mean and sd
mean_X = alpha*T;
sd_X = sigma*sqrt(T);

% overlay normal
plot(-2:0.0001:2,normpdf(-2:0.0001:2, mean_X, sd_X));
title('Simulation for random walk on lattice')
xlabel('simulated X')
ylabel('density')
legend('pdf of simulated X','Normal Density')
annotation( 'textarrow',[0.3,0.5],[0.7,0.6],'String','Normal Density')
hold off;

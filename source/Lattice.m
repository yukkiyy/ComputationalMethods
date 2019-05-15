%% Function LATTICE

function [X_new] = Lattice(N_simu,N,alpha,sigma,T,X_init)
% LATTICE simulates a random walk on lattice
% outputs the result of the random walk
% N_simu = number o simulations
% N = number of timesteps
% alpha = drift
% sigma = volatility
% T = expiry
% X_init = initial value 

% compute lattice factors

% timestep size
delta = T/N;

% up movement
u = sigma*sqrt(delta);

% down movement
d = -sigma*sqrt(delta);

% probability
p = 1./2.*(1.+alpha/sigma*sqrt(delta));

% define vector X
X_new = zeros(N_simu,1);
X_new(1:N_simu,1) = X_init;

ptest = zeros(N_simu,1);

% timestep loop
for i = 1:N
    
    % generate info for all simulations
    ptest(:,1) = rand(N_simu,1);
    % a matrix of 0 and 1 indicating direction of movements
    ptest(:,1) = (ptest(:,1) <= p);
    % get X
    X_new(:,1) = X_new(:,1) + ptest(:,1)*u + (1. - ptest(:,1))*d;
    
end 
    
end




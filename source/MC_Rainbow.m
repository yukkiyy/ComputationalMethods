function [V0] = MC_Rainbow(S0_1, S0_2, r, sigma_1, sigma_2, rho, K, T, M, N)
% MC_RAINBOW applies Monte Carlo to generate option value 
% Input parameters:
% S0_1: intial price for asset 1
% S0_2: initial price for asset 2
% r: risk free rate
% sigma_1: volatility for asset 1
% sigma_2: volatility for asset 2
% rho: correlation between asset 1 and 2
% K: strike price 
% T: expiry
% M: number of simulations
% N: number of time steps

%% initialize vectors
% asset price vector
S1 = zeros (M,1);
S1_next = zeros (M,1); 
S2 = zeros (M,1);
S2_next = zeros (M,1); 

% set seeds
rng(335)

% define epsilon
eps = 10^(-7);

% initialize S 
S1 (:,1) = S0_1;
S2 (:,1) = S0_2;

% determine time step size
delta = T/N; 

%% time step loop
for i = 1:N
    
    % compute random vector
    Z1 = randn(M,1);
    
    % vectorize to find S1 and S2
    S1_next (:,1) = S1 (:,1) + S1 (:,1).*(r*delta + sigma_1*sqrt(delta)*Z1);
    S1_next (:,1) = max (eps, S1_next (:,1));
    S1 (:,1) = S1_next (:,1); 
    S2_next (:,1) = S2 (:,1) + S2(:,1).*(r*delta + sigma_2*sqrt(delta)*(rho*Z1 + sqrt(1-rho^2)*randn(M,1)));
    S2_next (:,1) = max (eps, S2_next (:,1));
    S2 (:,1) = S2_next (:,1); 
    
end 

%% output European Call value and SD
V0 = exp(-r*T)*(1/M)*sum(max(K - max(S1_next, S2_next), 0)); 

end


function [t, P, S, V, B, H] = DeltaHedge(sigma, r, T, K, S0, mu, N)
% DELTAHEDGE perform delta hedging 
% input parameters
% sigma: volatility
% r: risk free rate
% T: expiry date
% K: strike
% S0: initial asset price
% mu: drift 
% N: number of rebalances

%% initialize book-keeping vectors
% portfolio value
P = zeros (N+1, 1); 
% option value
V = zeros (N+1, 1); 
% number of shares
alpha = zeros (N+1, 1);
% bank account
B = zeros (N+1, 1);
% asset price
S = zeros (N+1, 1);
% holding of asset 
H = zeros (N+1, 1);
% time 
t = zeros (N+1, 1); 

%% at time 0
P(1) = 0;
S(1) = S0;
V(1) = blsprice(S0, K, r, T, sigma);
alpha(1) = blsdelta(S0, K, r, T, sigma);
B(1) = V(1) - alpha(1) * S(1);
H(1) = alpha(1).* S(1);
t(1) = 0;

% timestep size
delta = T/N;

%% timestep loop 

for i = 2:N+1
    
    S(i) = S(i-1)*exp((mu-sigma^2/2)*delta + sigma*randn(1,1)*sqrt(delta));
    V(i) = blsprice(S(i), K, r, T - (i-1)*delta, sigma);
    
    if i == N+1
        
        alpha(i) = alpha(i-1);
        
    else 
        
        alpha(i) = blsdelta(S(i), K, r, T-(i-1)*delta, sigma);
        
    end 
    
    H(i) = alpha(i).* S(i);
    B(i) = exp(r*delta)*B(i-1) - S(i)*(alpha(i) - alpha(i-1));
    P(i) = - V(i) + alpha(i).*S(i) + B(i);
    t(i) = t(i-1) + delta; 
    
end 

end 



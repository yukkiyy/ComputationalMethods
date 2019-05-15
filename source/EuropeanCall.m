function [V0,SD] = EuropeanCall(S0, r, sigma, T, M, delta, K)
% EUROPEANCALL generates European Call price by Monte Carlo
% the input parameters are: 
% S0: initial asset price
% r: risk free rate
% sigma: volatility
% T: expiry date
% M: number of simulations
% delta: timestep size
% K: strike price of the option

%% set seed for random number generator
rng (335)

%% compute parameters for Monte Carlo
% number of time steps
N = T/delta; 

% define epsilon
eps = 10^(-7);

% asset price vector
S = zeros (M,1);
S_next = zeros (M,1); 

% initialize S 
S (:,1) = S0;

%% timestep loop 
for i = 1:N
    
    S_next (:,1) = S (:,1) + S (:,1).*(r*delta + sigma*sqrt(delta)*randn(M,1));
    S_next (:,1) = max (eps, S_next (:,1));
    S (:,1) = S_next (:,1); 
    
end 

%% output European Call value and SD
V0 = exp(-r*T)*(1/M)*sum(max(S_next - K, 0)); 
SD = std(max(S_next - K, 0).*exp(-r*T));

end


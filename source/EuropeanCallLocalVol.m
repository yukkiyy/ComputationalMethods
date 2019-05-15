function [V0] = EuropeanCallLocalVol(S0, r, alpha, T, M, delta, K)
% EUROPEANCALL generates European Call price by Monte Carlo
% the input parameters are: 
% S0: initial asset price
% r: risk free rate
% alpha: relationship between asset price and sigma
% T: expiry date
% M: number of simulations
% delta: timestep size
% K: strike price of the option

%% set seed for random number generator
rng (1)

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
    
    S_next (:,1) = S (:,1) + S (:,1).*r*delta + alpha*sqrt(delta)*randn(M,1);
    S_next (:,1) = max (eps, S_next (:,1));
    S (:,1) = S_next (:,1); 
    
end 

%% output European Call value and SD
V0 = exp(-r*T)*(1/M)*sum(max(S_next - K, 0)); 

end


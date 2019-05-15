function [V0] = EuropeanCallStochVol(S0, r, v_0, v_long, n, rho, lamda, T, M, N, K)
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
% time steps size
delta=T/N; 

% define epsilon
eps = 10^(-7);

% asset price vector
S = zeros (M,1);
S_next = zeros (M,1); 

% variance vector
v = zeros (M,1);
v_next = zeros (M,1);

% initialize S 
S (:,1) = S0;

% initialize v
v (:,1) = v_0;

%% timestep loop 
for i = 1:N
    
    % generate a random vector 
    Z1 = randn (M,1);
    % find asset prices
    S_next (:,1) = S (:,1) + S (:,1).*(r*delta + sqrt(v(:,1)).*sqrt(delta).*Z1);
    v_next(:,1) = v(:,1) - lamda.*(v(:,1) - v_long).*delta + n.*sqrt(v(:,1)).*(rho.*Z1 + sqrt(1-rho^2).*randn(M,1)).*sqrt(delta);
    S_next (:,1) = max (eps, S_next (:,1));
    v_next (:,1) = max (eps, v_next (:,1));
    S (:,1) = S_next (:,1); 
    v  (:,1) = v_next (:,1); 
    
end 

%% output European Call value and SD
V0 = exp(-r.*T).*(1/M)*sum(max(S_next - K, 0)); 

end


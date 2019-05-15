function [sigma] = Implied_Volatility(K,P_market)
%IMPLIED_VOLATILITY computes the implied volatility
% K is the strike price of the put option
% P is the market price o the put option

% define parameters
r = 0.035;
T = 22/365; 
S0 = 309.72; 
N = 1000;
opttype = 1;

% initial value of sigma
sigma = sqrt (abs ((2.0/T)*(log(S0/K) + r*T)));

% compute price of put option
P = bintree_cs335( S0, K, T, r , sigma, opttype, N);

% compute f of sigma
f = P_market - P;

% compute derivative of f
d = 1.0 * 10^(-7);
sigma_d = sigma + d;
d_f = - (bintree_cs335( S0, K, T, r , sigma_d, opttype, N)  - bintree_cs335( S0, K, T, r , sigma, opttype, N))/d;
sigma_plus = sigma - f/d_f;

% initialize k 
k = 0;

% initialize result vectors
result = [ k sigma f ];

% compute results for Newton Iteration
while abs(sigma_plus - sigma) >= 10^(-8)
    
    % update the index k 
    k = k +1;
    
    % update simga
    sigma = sigma_plus;
    
    % compute value of the put 
    P = bintree_cs335( S0, K, T, r , sigma, opttype, N);
    
    % compute f and d_f 
    f = P_market - P;
    sigma_d = sigma + d;
    d_f = - (bintree_cs335( S0, K, T, r , sigma_d, opttype, N)  - bintree_cs335( S0, K, T, r , sigma, opttype, N))/d;
    
    % generate next sigma value
    sigma_plus = sigma - f/d_f;
    
    % store result 
    result = [result ; k sigma_plus f];
    
end 

% set up the format
format longG

% compute table for the given strike price
T = array2table(result,...
    'VariableNames',{'Iterations','Sigmas','Functions'});
disp(T)

% define sigma 
sigma = result (k,2);

end


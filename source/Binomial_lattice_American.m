function [V] = Binomial_lattice_American(S0,K,T,r,sigma,N)
% BINOMIAL_LATTICE_AMERICAN Summary of this function goes here
% Takes in the following parameters:
% S0: current stock price
% K: strike price
% T: maturity of the option
% r: risk-free rate
% sigma: volatility factor
% type: 0 for call option, 1 for put option
% N: number of time steps
% Out put of the function
% v: value of the option as a reuslt of the binomal lattice

%% compute tree parameter

        % set step size
        delta = T/N;

        % compute other parameters
        u = exp(sigma * sqrt(delta));
        d = 1./u;
        a = exp(r * delta);
        p = (a - d) / (u - d);
        
        % define a variable payoff
        payoff = [];

%% find payoff at time T

        W = S0 * d.^( [N:-1:0]').* u.^( [0:N]');
        
        % compute the value at T for American put
        W = max( K - W, 0);
        
%% backward recursiive computation

        for i = N:-1:1
            
            % the value of the put if we continue to hold 
            W_cont = exp(-r * delta) * ( p*W(2:i+1) + (1-p)*W(1:i));
            % compute asset price at time i
            S = S0*d.^([i-1:-1:0]').*u.^([0:i-1]'); 
            % evaluate payoff at time i
            payoff = max(K-S,0); 
            % choose the optimal action
            W = max(W_cont,payoff);
           
        end
        
        V = W(1);

end



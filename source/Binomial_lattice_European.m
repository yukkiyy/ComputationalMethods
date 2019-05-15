function [V] = Binomial_lattice_European(S0,K,T,r,sigma,type,N)
% BINOMIAL_LATTICE_EUROPEAN Summary of this function goes here
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

%% find payoff at time T

        W = S0 * d.^( [N:-1:0]').* u.^( [0:N]');
        if (type == 0)
                W = max( W - K, 0);
        else
                W = max( K - W, 0);
        end
        
%% backward recursiive computation

        for i = N:-1:1
            
            W = exp(-r * delta) * ( p*W(2:i+1) + (1-p)*W(1:i));
           
        end
        
        V = W(1);

end


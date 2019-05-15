
 function [value] = bintree_cs335( S0, K, T, r , sigma, opttype, Nsteps)

% Compute Black-Scholes option value using a binomial tree

% S0 - current stock price
% K - strike
% T - expiry time
% r - interest rate
% sigma - volatility
% opttype - 0 for a call, otherwise a put
% Nsteps - number of timesteps

delt = T/Nsteps;

u = exp(sigma * sqrt(delt)  + (r - .5*sigma^2)*delt);
d = exp(-sigma * sqrt(delt) + (r - .5*sigma^2)*delt);


%
% payoff at t=T
%
     W =  S0*d.^([Nsteps:-1:0]').*u.^([0:Nsteps]');
     if( opttype == 0)
         W = max( W - K, 0);
     else
         W = max( K - W, 0);
     end

% backward recursion

  p = .5;

  for i=Nsteps:-1:1
      W = exp(-r*delt)*( p*W(2:i+1) + (1-p)*W(1:i) );
  end

  value = W;

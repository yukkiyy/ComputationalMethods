%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% CS 335 Assignment 2 Question 4 %%%%%%%%%
%%%%%%%%            Yao Yao (20304422)             %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clear all;

%%  define the inputs to the binomial lattice

% the parameters given

S0 = 100;
K = 100;
sigma = .25;
r = .05;
T = .75;
Ns = [500 1000 2000 4000 8000];
types = [0 1];


% set up the reuslt vector 
result = [];

%% compute the option values 

for i = 1:length(types)
    
    % compute the value of the call or put 
    type = types(i);
    
    for j = 1: length(Ns)
        
        % compute the value of the option for N steps
        N = Ns(j);
        V = Binomial_lattice_European(S0,K,T,r,sigma,type,N);
        result = [result V];
        
    end 
    
end 
        
%% return reuslt 

disp('result')
disp(result)

%% compute exact option price

% call option

[C,P] = blsprice(S0, K, r, T, sigma);
disp('exact call price')
disp(C)
disp('exact put price')
disp(P)




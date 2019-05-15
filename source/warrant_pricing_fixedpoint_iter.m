%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% CS 335 Assignment 3 Question 5 %%%%%%%%%
%%%%%%%%                        Part (a)                         %%%%%%%%%
%%%%%%%%            Yao Yao (20304422)             %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clear all;
clc;

%% find result with fixed point iteration

% define parameters
K = 100;
T = 2;
sigma = 0.35;
r = 0.03;
W = 18.84;
S0 = 100;

% set the precision 
format longG

% initialize beta and compute the next beta
beta = 0.4;
beta_plus = blsprice(S0 + (beta -1)*W, K, r, T, sigma)/W;

% compute residual for initial beta and next residual
residual = W - (1/beta)*blsprice(S0 + (beta -1)*W, K, r, T,sigma);
residual_plus = W - (1/beta_plus)*blsprice(S0 + (beta_plus -1)*W, K, r, T, sigma);

% set up vectors to store values o betas and residuals
B = [ beta beta_plus];
R = [ residual residual_plus];

% loop forward until the next one is within tolerance
while abs(beta - beta_plus) >= 10^(-7)
        
    % update beta  for the next result
    beta = beta_plus;
    
    % compute beta_plus for the current iteration
    beta_plus = blsprice(S0 + (beta -1)*W, K, r, T, sigma)/W;
    
    % compute residual for the current iteration
    residual_plus = W - (1/beta_plus)*blsprice(S0 + (beta_plus -1)*W, K, r, T, sigma);
    
    % store results for betas and residuals
    B = [B beta_plus];
    R = [R residual_plus];

end

% indexing the results
I = 0:1: length(B)-1;

% return results with indexing of betas and residuals
result = table(I',B',R');
result.Properties.VariableNames = {'Iterations','Betas','Residuals'};
disp('FIXED POINT ITERATIONS')
disp(result)


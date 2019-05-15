%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% CS 335 Assignment 3 Question 2 %%%%%%%%%
%%%%%%%%            Yao Yao (20304422)             %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clear all;
clc;

%% compute I_n with recursive calls

% set format of the numbers
format longG

% set up the initial value of I as I0
I_0 = 1 -(1/exp(1));

% define the vector for I_hat 
I_n = [ I_0 ];

% loop over n from 1 to 25

for n = 1:1:25
    
    % compute In_hat
    In = 1/(n+1) - (n^2/(n+1))*I_n(n);
    
    % generate I_hat
    I_n = [ I_n In ];
    
end 

result = table(I_n');
result.Properties.VariableNames = {'I_n'};
disp(result)

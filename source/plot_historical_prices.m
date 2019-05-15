%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% CS 335 Assignment 1 Question 6 (Yao Yao) %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%W%%%%%%%%%%%%%%%%%%%%%


    clear;
    clear all;

    %% Generate close_prices from a CSV file

    [dates, P] = close_prices_from_csv('/Users/yyukk/Desktop/CS335/A1/GSPC.csv');

    %% Compute normalized return vector 

    % number of entries
    n = length(P);

    % delta of prices
    delta_P = P(2:n) - P(1:n-1);

    % return R as a vector
    R = delta_P./P(1:n-1);

    % mean of R
    mu = mean(R);

    % standard deviation of R
    sd = std(R);

    % normalize R
    R_normalized = (R - mu)/sd;

    %% Plot the histogram and overlay a standard normal distribution 

    % plot histogram
    histogram_density (R_normalized, -6, 6, 50);
    hold on;

    % plot normal density
    plot(-6:0.01:6,normpdf(-6:0.01:6));

    % add title
    title('Historical Returns')
    xlabel('normalized returns')
    ylabel('density')
    hold off;
    
    % display drift and volatility
    disp('drift = ')
    disp(mu)
    disp('volatitly = ')
    disp(sd)


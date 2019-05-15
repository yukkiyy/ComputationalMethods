%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% CS 335 Assignment 1 Question 5 (Yao Yao) %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%W%%%%%%%%%%%%%%%%%%%%%

function histogram_density( xvec, a, b, nbins )
% HISTOGRAM_DENSITY
% Creates a plot of a probability density 
% based on sample data.
 
    % Size of a bin
    delta = (b - a) / nbins;
 
    % Bin edges
    binranges = a:delta:b;
 
    % Number of samples in each bin
    bincounts = histc(xvec, binranges);
 
    normalization_factor = delta*length(xvec);
    normalized = bincounts / normalization_factor;
 
    % Display the histogram 
    % subtract dx/2 so that the bars land in the middle of an interval)
    bar(binranges, normalized, 'histc');
 
end

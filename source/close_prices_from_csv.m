function [ dates, close_prices ] = close_prices_from_csv( csv_file_path )
%RETURNS_FROM_CSV Gets the dates and close prices from a CSV file.

    % Import the CSV file
    data_in = importdata(csv_file_path);

    % Close prices are in the 5-th column
    close_prices = data_in.data(:, 5);

    % Number of entries
    n = length(close_prices);

    % Monthly time interval
    time_interval = 1/12;
    today = 2015;

    % Make vector of dates corresponding to close prices
    dates = zeros( n, 1 );
    for i = 1:n
        dates(i) = today - (i-1) * time_interval;
    end

end

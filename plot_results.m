%% This function plots the output of a given vector of N elements
function [] = plot_results(output, index)
%% Check parameters
if (nargin < 2)
    index = 1;
end

%% Plot
figure(index);
plot(output);
grid on;
xlabel('iterations');
ylabel('I');
title('Evolution of the output value across iterations.');
end
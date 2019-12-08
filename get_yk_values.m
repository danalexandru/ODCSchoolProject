%% Description
% This function is meant to retrieve the values of dict_yk at a certain
% interation (all of them of the iteration is not specified)
function [y1, y2, y3] = get_yk_values(dict_yk, index)
%% Check initial parameters
if (nargin < 2)
    index = NaN;
end

%% Retrieve the values of dict_yk at the index iteration
y1 = dict_yk('y1');
y2 = dict_yk('y2');
y3 = dict_yk('y3');

if (~isnan(index))
    y1 = y1(index);
    y2 = y2(index);
    y3 = y3(index);
end

end
%% Description
% This method is meant to retrieve the last values of dict_yk, should it be
% necessary
function [y1, y2, y3] = get_yk_last_values(dict_yk)
%% Retrieve the last values of dict_yk
y1 = dict_yk('y1');
y2 = dict_yk('y2');
y3 = dict_yk('y3');

y1 = y1(end);
y2 = y2(end);
y3 = y3(end);

end
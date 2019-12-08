%% Description
% This function returns the value of a function given the identification
% and the current values of yk
function [Ik] = get_function_value(dict_ident_data, dict_yk)
%% Retrieve data from dict_ident_data
a0 = dict_ident_data('a0');
a1 = dict_ident_data('a1');
a2 = dict_ident_data('a2');
a3 = dict_ident_data('a3');

%% Retrieve the last values of dict_yk
[y1, y2, y3] = get_yk_last_values(dict_yk)

%% Return Ik value
Ik = a0 + a1*y1^2 + a2/y2 + a3*y3;
end
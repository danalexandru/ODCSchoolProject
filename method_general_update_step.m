%% Description
% This method updates the step at every iteration
function [sk] = method_general_update_step(dict_ident_data, dict_yk, d)
%% Retrieve data from dict_ident_data
a0 = dict_ident_data('a0');
a1 = dict_ident_data('a1');
a2 = dict_ident_data('a2');
a3 = dict_ident_data('a3');

%% Retrieve the last values of dict_yk
[y1, y2, y3] = get_yk_last_values(dict_yk);

%% Define the y(k+1) format
sk = sdpvar(1);

F = [a0 + a1*(y1 + sk*d(1))^2 + a2 / (y2 + sk*d(2)) + a3*(y3 + sk*d(3))^2 == ...
    min(a0 + a1*(y1 + sk*d(1))^2 + a2 / (y2 + sk*d(2)) + a3*(y3 + sk*d(3))^2)];

sol = solvesdp(F);
sk = double(sk);

end

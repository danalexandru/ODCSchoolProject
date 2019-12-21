%% Description
% !!! Deprecated: This method updates the step at every iteration
function [sk] = method_general_update_step(dict_ident_data, dict_yk, d)
%% Retrieve data from dict_ident_data
a0 = dict_ident_data('a0');
a1 = dict_ident_data('a1');
a2 = dict_ident_data('a2');
a3 = dict_ident_data('a3');

%% Retrieve the last values of dict_yk and the directions
[y1, y2, y3] = get_yk_last_values(dict_yk);
d1 = d(1);
d2 = d(2);
d3 = d(3);

%% Write the I(s) function as a fraction of 2 polynomials A(s)/B(s)
alpha_3 = (a1 * (d1^2 * d2) + a3 * (d3^2 * d2));
alpha_2 = (a1 * ((y2 * d1^2) + (2 * y1 * d1 * d2)) + ...
    a3 * ((y2 * d3^2) + (2 * y3 * d3 * d2)));
alpha_1 = (a0 * d2 + a1 * ((2 * y1 * y2 * d1) + (y1^2 * d2)) + a3 * ((2 * y3 * y2 * d3) + (y3 * d2)));
alpha_0 = (a0 * y2 + a1 * (y1^2 * y2) + a2 + a3 * (y3^2 * y2));

beta_1 = d2;
beta_0 = y2;

%% Return step
I = @(s) (alpha_3 * s^3 + alpha_2 * s^2 + alpha_1 * s + alpha_0) / (beta_1 * s + beta_0);
sk = fminsearch(I, rand(1));

end

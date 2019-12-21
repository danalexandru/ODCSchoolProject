%% Description
% !!! Deprecated This method updates the Cauchy step at every iteration
function [sk] = method_cauchy_update_step(dict_ident_data, dict_yk, ignore_deprecation)
%% Check parameters
if (nargin < 3)
    ignore_deprecation = 0;
end

if (ignore_deprecation == 1)
    %% Retrieve data from dict_ident_data
    a0 = dict_ident_data('a0');
    a1 = dict_ident_data('a1');
    a2 = dict_ident_data('a2');
    a3 = dict_ident_data('a3');

    %% Retrieve the last values of dict_yk
    [y1, y2, y3] = get_yk_last_values(dict_yk);

    %% Calculate parameters for the a*sk^2 + b*sk + c function
    a = (4 * a1^3 * y1^2) + ((a2^3)/(y2^4)) + (4 * a3^3 * y3^2);
    b = (-4 * a1^2 * y1^2) + ((2*a2^2)/(y2)) - (4 * a3^2 * y3^2);
    c = a0 + (a1 * y1^2) + (a2 * y2^2) + (a3 * y3^2);

    %% Calculate the 2 possible solutions
    sk1 = (-b - sqrt(b^2 - 4*a*c)/(2*a));
    sk2 = (-b + sqrt(b^2 - 4*a*c)/(2*a));

    %% Determine the step
    if (sk1 > 0)
        sk = sk1;
    elseif (sk2 > 0)
        sk = sk2;
    else
        sk = NaN;
    end
else
    sk = NaN;
end
end

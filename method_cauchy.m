%% Description
% This method implements the Cauchy Optimization Method, with a constant
% or variable step
function [dict_yk, minI, sk_all] = method_cauchy(dict_ident_data, dict_init_data, tolerance, sk)
%% Check initial parameters
if (nargin < 4)
    variable_step = 1;
else
    variable_step = 0;
end

%% Initialize dictionaries
dict_yk = containers.Map;

dict_yk('y1') = dict_init_data('y10');
dict_yk('y2') = dict_init_data('y20');
dict_yk('y3') = dict_init_data('y30');

%% Initialize gradient and yk
gradient = [...
    2*dict_ident_data('a1')*dict_init_data('y10'); ...
    -dict_ident_data('a2')/(dict_init_data('y20')^2); ...
    2*dict_ident_data('a3')*dict_init_data('y30')...
    ];

yk = [...
    dict_init_data('y10'); ...
    dict_init_data('y20');...
    dict_init_data('y20');...
    ];

minI = get_function_value(dict_ident_data, dict_yk);
sk_all = [];
%% Start Cauchy Algorithm
i = 0;
while (norm(gradient) > tolerance)
    %% Update step
    if (variable_step)
        sk = method_cauchy_update_step(dict_ident_data, dict_yk);
        sk_all = [sk_all sk];
    end
    
    %% Update yk
    yk = yk - sk * gradient;
   
    %% Update gradient
    gradient = [...
        2*dict_ident_data('a1')*yk(1); ...
        -dict_ident_data('a2')/(yk(2)^2); ...
        2*dict_ident_data('a3')*yk(3)...
    ];

    %% Update dict_yk
    dict_yk('y1') = [dict_yk('y1'); yk(1)];
    dict_yk('y2') = [dict_yk('y2'); yk(2)];
    dict_yk('y3') = [dict_yk('y3'); yk(3)];
   
    %% Add the new minI
    minI = [minI get_function_value(dict_ident_data, dict_yk)];
    
    %% Debug mode
    i = i + 1;
    debug_message = strcat('i = ', num2str(i), ', min(I) = ', num2str(minI(end)), ';');
    display(debug_message);
end

end

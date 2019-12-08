%% Description
% This method implements the Cauchy Optimization Method, with a constant
% step
function [dict_yk, minI] = method_cauchy_constant_step(dict_ident_data, dict_init_data, tolerance, sk)
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

%% Start Cauchy Algorithm

while (norm(gradient) > tolerance)
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
end

end

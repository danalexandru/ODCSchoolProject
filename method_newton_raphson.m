%% Description
% This method implements the Newton-Raphson Optimization Method with a
% variable step
function [dict_yk, minI, sk_all] = method_newton_raphson(dict_ident_data, dict_init_data, tolerance, sk)
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
gradient_0 = [...
    2*dict_ident_data('a1')*dict_init_data('y10'); ...
    -dict_ident_data('a2')/(dict_init_data('y20')^2); ...
    2*dict_ident_data('a3')*dict_init_data('y30')...
    ];

gradient_1 = [...
    2*dict_ident_data('a1')*dict_init_data('y10'); ...
    -dict_ident_data('a2')/(dict_init_data('y20')^2); ...
    2*dict_ident_data('a3')*dict_init_data('y30')...
    ];

yk_0 = [...
    dict_init_data('y10'); ...
    dict_init_data('y20');...
    dict_init_data('y20');...
    ];

F0 = 0;
F1 = get_function_value(dict_ident_data, dict_yk);

Bk = 0;

sk_all = [];
minI = F1;

%% Initialize Hessian
hessian = [...
    2*dict_ident_data('a1') 0 0; ...
    0 2*dict_ident_data('a2')/(yk_0(2)^3) 0; ...
    0 0 2*dict_ident_data('a3')
    ];

%% Start Newton-Raphson Algorithm
i = 0;
while (abs(F1 - F0) > tolerance)
    %% Get direction
    direction = -hessian^-1 * gradient_0;
    
    %% Update step
    if (variable_step)
        sk = method_general_update_step(dict_ident_data, dict_yk, direction);
        sk_all = [sk_all sk];
    end
        
    %% Calculate y(k + 1)
    yk_1 = yk_0 + sk * direction;
    
    %% Update gradient
    gradient_0 = gradient_1;
    gradient_1 = [...
        2*dict_ident_data('a1')*yk_1(1); ...
        -dict_ident_data('a2')/(yk_1(2)^2); ...
        2*dict_ident_data('a3')*yk_1(3)...
    ];

    %% Update Hessian
    hessian = [...
        2*dict_ident_data('a1') 0 0; ...
        0 2*dict_ident_data('a2')/(yk_1(2)^3) 0; ...
        0 0 2*dict_ident_data('a3')
        ];
    
    %% Update dict_yk
    dict_yk('y1') = [dict_yk('y1'); yk_1(1)];
    dict_yk('y2') = [dict_yk('y2'); yk_1(2)];
    dict_yk('y3') = [dict_yk('y3'); yk_1(3)];
    
    %% Calculate new minimum
    F0 = F1;
    F1 = get_function_value(dict_ident_data, dict_yk);
    
    minI = [minI F1];
    
    %% Debug mode
    i = i + 1;
    debug_message = strcat('i = ', num2str(i), ', min(I) = ', num2str(minI(end)), ';');
    display(debug_message);
    
    if (minI(end) == -inf)
        break
    end
end

end

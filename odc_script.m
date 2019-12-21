%% Description
% This is the main script from which all the methods will be called upon
function [] = odc_script()
%% Clear console
clc;
clear;

%% Retrieve the initial data required
[dict_ident_data, dict_init_data] = get_initial_data();

%% Use Caucky method for a constant step
tolerance = 0.01;
sk = 0.1;

[dict_yk, minI] = method_cauchy(dict_ident_data, dict_init_data, tolerance, sk);

%% Use Caucky method for a variable step
tolerance = 0.01;

[dict_yk, minI, sk] = method_cauchy(dict_ident_data, dict_init_data, tolerance);


%% Use Fletcher-Powell method for a variable step
tolerance = 0.01;

[dict_yk, minI, sk] = method_fletcher_powell(dict_ident_data, dict_init_data, tolerance);

%% Use Fletcher-Powell method for a variable step
tolerance = 0.01;

[dict_yk, minI, sk] = method_fletcher_reeves(dict_ident_data, dict_init_data, tolerance);

%% Plot results
plot_results(minI, 1);

end
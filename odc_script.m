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

[dict_yk, minI] = method_cauchy_constant_step(dict_ident_data, dict_init_data, tolerance, sk);

%% Plot results
plot_results(minI, 1);

end
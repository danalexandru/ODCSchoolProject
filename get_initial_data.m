%% Descriptions
% This method returns the initial data required in order to apply
% optimisation algorithms for a function of type: 
% I(y) = a0 + a1 * y1^2 + a2* (1/y2) + a3*y3^2
function [dict_ident_data, dict_init_data] = get_initial_data()
%% Get the identification data
% dict_ident_data = containers.Map;

% dict_ident_data('a0') = randn(1);
% dict_ident_data('a1') = randn(1);
% dict_ident_data('a2') = randn(1);
% dict_ident_data('a3') = randn(1);

dict_ident_data = get_identification_data('castr_odc_project_dataset.csv');

%% Get the initial values
dict_init_data = containers.Map;

dict_init_data('y10') = randn(1);
dict_init_data('y20') = randn(1);
dict_init_data('y30') = randn(1);

end

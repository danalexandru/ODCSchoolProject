%% Descriptions
% This method returns the initial data required in order to apply
% optimisation algorithms for a function of type: 
% I(y) = a0 + a1 * y1^2 + a2* (1/y2) + a3*y3^2
function [dict_ident_data, dict_init_data] = get_initial_data()
%% Get the identification data
dict_ident_data = containers.Map;

dict_ident_data('a0') = randi(10);
dict_ident_data('a1') = randi(10);
dict_ident_data('a2') = randi(10);
dict_ident_data('a3') = randi(10);

%% Get the initial values
dict_init_data = containers.Map;

dict_init_data('y10') = randi(10);
dict_init_data('y20') = randi(10);
dict_init_data('y30') = randi(10);

end

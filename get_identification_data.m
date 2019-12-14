%% Description
% This method returns the identification data (a0, a1, a2, a3) from the
% initial data from a csv file
function [dict_ident_data] = get_identification_data(csv_file)
%% Check parameters
if (nargin < 1)
    %% Get default csv file
    csv_file = 'castr_odc_project_dataset.csv';
end

%% Extract data from the csv
csv_data = readtable(csv_file);
[m, n] = size(csv_data);

%% Take the data and format them into matrixes
Y = csv_data{1 : end, 1 : end - 1};
I = csv_data{1 : end, end};

Y = [...
    ones(m, 1) ...
    Y(1 : m, 1).^2 ...
    1./Y(1 : m, 2) ...
    Y(1 : m, 3).^2 ...
    ];

%% Get the answer to the YA = I equation
N = min(m, n);
A = (Y(1 : N, 1 : N))^(-1) * I(1 : N);

%% Put the A results into a dictionary
dict_ident_data = containers.Map;

dict_ident_data('a0') = A(1);
dict_ident_data('a1') = A(2);
dict_ident_data('a2') = A(3);
dict_ident_data('a3') = A(4);

end
function I = comp_trap_vector(x,y)
% I = comp_trap_vector(x,y)
% Performs composite trapezoidal rule
%
% INPUTS:
%  - x: independent variable
%  - y: dependent variable
% OUTPUT:
%  - I: integral value
I = 0;

%Evaluating integral

for i = 2:length(x)
    h = (x(i)- x(i-1));
    I = I + h/2*(y(i-1) + y(i));
end
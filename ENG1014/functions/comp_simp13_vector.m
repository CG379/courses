function I = comp_simp13_vector(x,y)
% I = comp_simp_vector(x,y)
% Performs composite simpson's 1/3 rule
%
% INPUTS:
%  - x: independent variable
%  - y: dependent variable
% OUTPUT:
%  - I: integral value

% width and number of points
h = x(2)-x(1);
n = length(x);

% error checking
if (n < 3) || (rem(n,2) == 0)
    error('Inappropriate number of points for integration')
end

%Evaluating integral
even_sum = 4*sum(y(2:2:end-1));
odd_sum = 2*sum(y(3:2:end-2));
I = h/3*(y(1) + even_sum + odd_sum + y(end));
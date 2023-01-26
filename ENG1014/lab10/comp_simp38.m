function I = comp_simp38(f,a,b,n)
% I = comp_simp38(f,a,b,n)
% Performs composite simpson's 3/8 rule
%
% INPUTS:
%  - f: function handle of equation 
%  - a: starting integral limit
%  - b: ending integral limit
%  - n: number of points 
% OUTPUT:
%  - I: integral value

if (n < 3) || (rem(n,3) ~= 0)
    error('Inappropriate number of points for integration')
end
x = linspace(a,b,n);

h = (b-a)/(n-1);

i = sum(x(2:3:(n-2)));
j = sum(x(3:3:(n-1)));
k = sum(x(4:3:(n-3)));

I=(3*h/8)*(f(a) + 3*i+ 3*j + 2*k+f(b));
end


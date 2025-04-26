function [t,y] = euler(dydt,tspan,y0,h)
% [t,y] = euler(dydt,tspan,y0,h):
% INPUTS:
%  - dydt = function handle of the ODE, f(t,y)
%  - tspan = [<initial value>, <final value>] of independent variable
%  - y0 = initial value of dependent variable
%  - h = step size
% OUTPUTS:
%  - t = vector of independent variable
%  - y = vector of solution for dependent variable

% error checking for tspan ~ means NOT
if ~(tspan(2)>tspan(1))
    error('upper limit must be greater than lower')
end

% Create t as a vector 
t = (tspan(1):h:tspan(2));

% if necessary, add an additional t so that range goes up to tspan(2)
if t(end) < tspan(2)
    t(end+1) = tspan(2);
end

% Implement Euler's method
y = y0*ones(size(t)); %pre-allocation

for i = 1:length(t)-1
    y(i + 1) = y(i) + h*dydt(t(i),y(i));
end
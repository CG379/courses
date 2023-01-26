function [t,y] = heun(dydt,tspan,y0,h)
% [t,y] = heun(dydt,tspan,y0,h):
% uses Heun's method to solve an ODE
%
% INPUTS:
%  - dydt = function handle of the ODE, f(t,y)
%  - tspan = [<initial value>, <final value>] of independent variable
%  - y0 = initial value of dependent variable
%  - h = step size
% OUTPUTS:
%  - t = vector of independent variable
%  - y = vector of solution for dependent variable

% Input Validation: tspan
if ~(tspan(2)>tspan(1))
    error('upper limit must be greater than lower')
end

% Create all independant values, t
t = (tspan(1):h:tspan(2));

% if necessary, add an additional t so that range goes up to tspan(2)
if t(end) < tspan(2)
    t(end+1) = tspan(2);
end
% Implement Heun's method
y = y0*ones(size(t)); % Preallocate y to improve efficiency

for i = 1:length(t)-1
    ypred = y(i) + h*dydt(t(i),y(i));
    y(i+1) = y(i) + h*(dydt(t(i),y(i))+dydt(t(i+1),ypred))/2;
end
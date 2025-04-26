% Campbell Gregor
% Last modified: 19/10/22
% 33110018

clc; clear all; close all;

ODE = @(x,y) (y.^2 .* sin(x) + x.^2 .* cos(y))./(2.*x.*y);

h = [0.01,0.005,0.001];
span = [50,70];
y0 = 1.57;
hold on;

[t,y] = ode45(ODE,50:h(1):70,y0);
plot(t,y)

for i = h
[t1,y1] = midpoint(ODE,span,y0,i);
plot(t1,y1);
end

hold off;

xlabel("t");
ylabel("y");

legend("ODE45", "h = 0.01","h = 0.005","h = 0.001","Location","best");
title("ODE solutions with various incriments");




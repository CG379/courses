% Campbell Gregor
% Last modified: 19/10/22
% 33110018

clc; clear all; close all;
%% Part 1
dy = @(t,y) 3.*exp(t) - (8.*y)./3;

interval = [0,3];

y0 = 3;

h = [1,0.75,0.5,0.001];
comps = [];
hold on;
for i = h
    [t,y1] = euler(dy,interval,y0,i);
    plot(t,y1)
    comps = [comps,y1(end)];
end


xlabel("t");
ylabel("y");
title("ODE Solutions for different step values");

%% Part 2
y = @(t) (9/11).*exp(t) + (24/11).*exp((-8/3).*t);

analytical = plot(1:0.1:3,y(1:0.1:3));
legend("h = 1","h = 0.75", "h = 0.5", "h = 0.001","Analytical Solution","Location","best");
hold off;

%% Part 3

error = @(yApprox,yAnalytical) abs((yApprox - yAnalytical)./(yAnalytical)) .* 100;

errors = error(comps,y(3));

fprintf("h: \t 1, \t 0.75, \t 0.5, \t 0.001\n");
fprintf("Error %%: %4.2f %6.2f %7.2f %7.2f\n", errors);



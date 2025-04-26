% Campbell Gregor
% Last modified: 18/8/22
% 33110018

clc; clear all; close all;

%% Calculations
x = 500;
y = 100;
deg = 1:1:360;

r = 100;

xord = @(x, theta, r) (cosd(theta) .* r) + r;
yord = @(y, theta, r) (sind(theta) .* r) + x + r;


horizontal = 0:1:100;
vertical = horizontal * 5;

%% Plotting
plot(horizontal,vertical,"m--",xord(x,deg,r),yord(y,deg,r),"m--");
xlabel("x-position");
ylabel("y-position");
title("Flight Path");
grid on;
% Campbell Gregor
% Last modified: 20/9/22
% 33110018

clc; clear all; close all;

g = 9.81;
v0 = 22;
y0 = 2.1;
x = 36;
y = 1.1;
prec = 1e-4;


y = @(theta) tand(theta).* x - (g./(2 .* v0^2 .* (cosd(theta)).^2)).* x^2 + y0 - y;

%% Finding the root

[angle, i] = secant(y,15,60,prec);

fprintf("The initial angle was %.2f degrees, it took %d itterations.\n", angle,i);

angles = 0:0.1:60;



%% Plot
plot(angles,y(angles), angle,y(angle), "r^")
xlabel("Angle (deg)")
ylabel("Vertical Displacement (m)")
yticks(0);
grid on;
title("Ball Displacement")
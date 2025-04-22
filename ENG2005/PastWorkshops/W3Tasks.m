clear; % clear variables
clc; % clear command window
close all
%% Q4
clc,clear
theta = 0:0.01:2*pi;
rho = cos(3*theta);
polarplot(theta,rho);


%% Q5 iv

clear
syms r ph z
%define limits of integration
zmin = 0;
zmax = 1;
phmin = 0;
phmax = 2*pi;
rmin = z;
rmax = sqrt(z);
%define the iterated triple integral
I=int(int(int(r,r,rmin,rmax),z,zmin,zmax),ph,phmin,phmax)

%% Q6

% angle domain
angle = linspace(0, 2*pi, 100);

% functions
r1 = 4*sin(angle);
r2 = 2 + 2*sin(angle);

% Plot both functions
polarplot(angle, r1, 'b', angle, r2, 'r');
title('4*sin(angle) and 2 + 2*sin(angle)');
legend('4*sin(angle)', '2 + 2*sin(angle)');
grid on;

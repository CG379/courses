clear all
close all
clc

%% Part 1- modelling a segment of the opera house using a sphere 

figure('Name', 'Part 1')

% plotting a sphere in MATLAB requires converting phi, theta and r into x,
% y and z coordinates. 

%linspace is a function that produces a set number of points between two
%numbers, in this case 0 and 100

theta=linspace(0,pi/2,100); %defining angles for theta
phi=linspace(0,pi/2,100); %degining angles for phi 

%meshgrid produces an n x m matrix x points placed horizontally along the
%matrix and y points placed vertically along the matrix

[theta,phi]=meshgrid(theta,phi); %meshgrid converts coordinates into table format

%the radius is...
rho=1; 

%defining x, y and z coordinates
x1=rho*sin(phi).*cos(theta); 
y1=rho*sin(phi).*sin(theta);
z1=rho*cos(phi);
surf(x1,y1,z1)

%labelling axis coordinates
xlabel('x')
ylabel('y')
zlabel('z')

%adding a title to the plot
title('P1- Segment derived from sphere (x^2+y^2+z^2=1)')

%parameterizations - yes, there's a way to do this on MATLAB :^)
syms theta_sym phi_sym

%the paramaterized surface is defined as ...
f=[sin(phi_sym)*cos(theta_sym),sin(phi_sym)*sin(theta_sym),cos(theta_sym)];

%the partial diff of the surface f with respect to phi and theta
dfdphi=diff(f,phi_sym);
dfdtheta=diff(f,theta_sym);

%taking the cross product of both partial diffs 
crossP1=cross(dfdphi,dfdtheta);

%the parameterized vector field
F= [sin(phi_sym)*cos(theta_sym),sin(phi_sym)*sin(theta_sym),5];

% taking the dot product between F and the cross product found before
dotP1=dot(F,crossP1);

%finding the double integral
int1 = int(int(dotP1, theta_sym, 0, pi/4), phi_sym, 0, pi/2);

% representing the final answer in decimal form
final_answer_P1=double(int1);

fprintf(' The final answer (for P1) is: %.2f',final_answer_P1)


clc; clear all; close all;

x = -1:0.05:1;
y = -1:0.05:1;
[xx,yy] = meshgrid(x,y);
h = 1 + 0.1*exp(-3*xx.^2 + 2*xx.*yy - 3*yy.^2);

figure(1);
mesh(xx,yy,h)
xlabel("x");
ylabel("y");
zlabel("h(x,y)")


eps = 0:0.005:1;
%% Part A

% Path
xpath = 0.1 .* sin(10.* pi .* eps) - eps;
ypath = 0.1 .* sin(10.* pi .* eps) + eps;

% Height along that path
h2 = 1 + 0.1*exp(-3*xpath.^2 + 2*xpath.*ypath - 3*ypath.^2);


grid on;
line(xpath,ypath,h2,'linewidth',2,'color','r');

points = [0, 0;1/4, -1/4;-1/4, 1/4;1/ 8, -1/ 8;-1/ 8,1/ 8];

figure(2);
hold on;
contour(xx,yy,h)
plot(points(:,1),points(:,2),"o");
axis equal
xlabel("x");
ylabel("y");
title("Contour Plot Q4");
hold off;
% Slope vector 
SlopeVector = exp(-3.*xpath.^2 + 2.* xpath .* ypath - 3 .*ypath).*...
    (((0.2 .* ypath - 0.6.*xpath).* (pi .* cos(10.* pi.* eps) + 1))+(0.2 .* xpath - 0.6.*ypath).* (pi .* cos(10.* pi.* eps) - 1));

figure(3)
yyaxis left;
plot(eps,h2)
xlabel("ξ");
ylabel("Height (m)")
yyaxis right;
plot(eps,SlopeVector,"r");
ylabel("Slope");
title("Height and Slope along the path");

%% Part B
figure(4);
% Velocity
V = @(t) 100.*tanh(t./100);
% Distance
D = @(t) 10000.*log(cosh(x./100));

t = linspace(0,56.151,41);


Dist = D(t);
Vel = V(t);

plot(Dist,Vel)
xlabel("Distance (m)");
ylabel("Velocity (m/s)");
title("Part B Q4 plot");




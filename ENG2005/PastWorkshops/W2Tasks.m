clear; % clear variables
clc; % clear command window
close all
%% 3B
% Define the function
syms x
z = (sin(x))^2;
% Calculate derivative
dz_dx = diff(z)

%% 3
clear; % clear variables
clc; % clear command window
close all
[x, y] = meshgrid(-4:0.1:4);
f = 4 - x.^2 -2.* y.^2;

figure;
mesh(x, y, f);
hold on;
plot3(1,1,1, "ko")
xlabel('x');
ylabel('y');
zlabel('f(x, y)');
title('f(x, y)');

%% 4a
clear; % clear variables
clc; % clear command window
close all


f =@(x,y) - (x.^2 + y.^2)./4 + 1;
x = linspace(-2.5, 2.5);
y = linspace(-2.5, 2.5);
[X, Y] = meshgrid(x, y);
Z = f(X, Y);

% Get rid of values below sea level, z < 0
Z(Z < 0) = NaN;
% Define the function f(x, y)
f = @(x, y) - (x.^2 + y.^2) ./ 4 + 1;

% plot
surf(X, Y, Z);
xlabel('x');
ylabel('y');
zlabel('z (km)');
% Plot ocean at z = 0
%fsurf(0, [-2,2,-2,2]);
%% Contoure plot 4c
close all;
clc;
% Specify levels
levels = [0, 0.25, 0.5];

% Contour plot using existing data, specify levels = 2 
contourf(X, Y, Z, levels);
% Labels
xlabel('x');
ylabel('y');
title('Contour Plot of z (km)');

%% 4f 
% When I publish the vector gets lost behind the graph.
close all;
clc;
% Landing position (x, y) on the island
x_pos = 1/2;
y_pos = 1/2;

% Calculate the -ve gradient at landing pos
df_dx = -x_pos/2; 
df_dy = -y_pos/2;
nve_grad_vec = [-df_dx, -df_dy,-1];
% z = 0, since only showing x-y direction

% Normalize the negative gradient vector to get the unit vector
mag = norm(nve_grad_vec);
slip_vec = nve_grad_vec / mag;


surf(X, Y, Z);
xlabel('x');
ylabel('y');
zlabel('z (km)');
hold on;
quiver3(1/2, 1/2, f(1/2,1/2), slip_vec(1), slip_vec(2), slip_vec(3), 'r', 'LineWidth', 2);
hold off;


 %% 4g
close all;
clc;
% Variables
w = 2 * pi / 365;
T0 = 0;
T1 = 10;
lambda = 0.2;
% Function itself
syms z t
T = T0 + T1.* exp(-lambda .* z).* sin(w.* t - lambda.*z);
% Plot with labels
ezmesh(T);
zlabel("T(z,t) (C)");
title('T(z, t)');


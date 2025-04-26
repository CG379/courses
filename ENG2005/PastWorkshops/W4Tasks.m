clc % clear command window
clear % clear all variables
close all % close all graphics windows

%% 1bi
clc % clear command window
clear % clear all variables
close all % close all graphics windows
% x and y intervals
x= -3:0.1:3;
y=-3:0.1:3;
% scalar field
[X, Y] = meshgrid(x,y);
ZZ = (2.*X - Y)./(X.^2 + Y.^2);
%contours at -1, 0, 1
[C, h] = contour(X,Y,ZZ,[-1,0,1],'LineWidth',1.5);
xlabel('x');
ylabel('y');
title('Level curves of ?(x,y)');
axis equal;
clabel(C,h);
grid on;

%% 1bii
clc % clear command window
clear % clear all variables
close all % close all graphics windows
% Function
syms func(x,y)
func(x,y) = (2.*x - y)./(x.^2 + y.^2);
% Limits of function
fsurf(func,[-2 2 -2 2])
xlabel('x'); ylabel('y'); zlabel('z');
title('(2*x -y)/(x^2+y^2)');
axis equal;
zlim([-2 2])
hold on

%% 1c
clc % clear command window
clear % clear all variables
close all % close all graphics windows
[x, y, z] = meshgrid([-1 0 1]);
u = x*0+1; % x-component of vector field
v = y*0+2; % y-component of vector field
w = z*0; % z-component of vector field
% (if a component is zero, 0*x creates a vector of the right size)
quiver3(x, y, z, u, v, w);
axis equal
axis([-1.5 1.5 -1.5 1.5 -1.5 1.5]);
xlabel('x'); ylabel('y'); zlabel('z');
%% Surfaces , gradient vectors and normal vectors - 1e
clc % clear command window
clear % clear all variables
close all % close all graphics windows
syms x y
% New functions
f = (x+y).^2;
g = 2 - ((x./2).^2 + (y./2).^2);
[X,Y] = meshgrid(-2:0.1:2,-2:0.1:2);
Z = double(subs(f,[x,y],{X,Y}));
%create a surface with a contour plot beneath
surfc(X,Y,Z,'EdgeColor','none');
%add labels
xlabel('x'); ylabel('y'); zlabel('z=f(x,y)'); title('f(x,y)=x^2+y^2'); axis equal;
hold on
% Second function
[Xv,Yv] = meshgrid(-2.:0.5:2,-2.:0.5:2);
Z2 = double(subs(g,[x,y],{Xv,Yv}));

% second surface
surfc(Xv,Yv,Z2,'EdgeColor','none');

axis equal
light('po',-[0 3 0],'col',[1 1 1]);
% Changed from k to w since writting was in black as well
set(gcf,'color','w')
light('Position',[1 3 2]); light('Position',[-3 -1 3]);
hold on
%Add an antenna: [1.6 3]. if you want to make it longer, change 3
for i=(1:8)*pi/4
plot3([.8*cos(i) 0],[.8*sin(i) 0],[1.6 3],'w');
end
hold off

%% symbolical calculation of curl and div: 2a
clc % clear command window
clear % clear all variables
close all % close all graphics windows
syms x y z real
F = [ cos(x+2*y), sin(x-2*y) ];
G = curl([F,0],[x y z]) %curl accepts a 3D vector made of [F,0]
D = divergence(F,[x y]) %2D divergence
%plot the vector field in 3D, define the mesh and the vector components
[x, y, z] = meshgrid(-2:.3:2);
u = cos(x+2*y); % x-component of vector field
v = sin(x-2*y); % y-component of vector field
w = 0.*z; % z-component of vector field
quiver3(x, y, z, u, v, w,1);
xlabel('x'); ylabel('y'); zlabel('z');
axis equal


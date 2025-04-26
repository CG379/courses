% Worksheet week 4
close all

%% MATLAB Task: Exploration and designing your own space-shuttle
%% Surfaces, gradient vectors and normal vectors
clear
syms x y
f = x^2+y^2+1;
g = gradient(f);

[X,Y] = meshgrid(-2:0.1:2,-2:0.1:2);
Z = double(subs(f,[x,y],{X,Y}));
%create a surface with a contour plot beneath
surfc(X,Y,Z,'EdgeColor','none');
%add labels
xlabel('x'); ylabel('y'); zlabel('z=f(x,y)'); title('f(x,y)=x^2+y^2'); axis equal;
hold on
%calculate  grad f = (G1,G2), where G1 and G2 are f_x, f_y)
[Xv,Yv] = meshgrid(-2.:0.5:2.,-2.:0.5:2.);
G1 = subs(g(1),[x,y],{Xv,Yv});
G2 = subs(g(2),[x,y],{Xv,Yv});
% plot the 2D gradient vector field on the domain, at z=0
quiver(Xv,Yv,G1,G2)
%let's calculate the normal vector N to surface f(x,y):
%N=grad (f(x,y)-z) =(f_x,f_y,f_z)=(f_x,f_y,-1)
%define Zv=(f(Xv,Yv)) coordinate by 
%replacing OLD [x,y] with NEW {Xv,Yv} in the symbolic expression f.
Zv = subs(f,[x,y],{Xv,Yv});

% draw normal vectors to the surface 
% using N=(f_x,f_y,-1)=[G1,G2,-ones(size(Xv))]
quiver3(Xv,Yv,Zv,G1,G2,-ones(size(Xv)),'r')
% note that quiver and quiver3 automatically scale the vectors so that they
% do not overlap.
axis equal
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
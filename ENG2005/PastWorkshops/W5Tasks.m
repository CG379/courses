clear; % clear variables
clc; % clear command window
close all

%% 1c
clear; % clear variables
clc; % clear command window
close all
t = 0:0.1:2*pi;
x= t;
y =sin(t);
z = cos(t);

plot3(x,y,z);
xlabel('x');
ylabel('y');
zlabel('z');
title("l(t) = ti + sin(t)j + cos(t)k")
grid on;

%% Task 6.1
% Altered from lecture notes
clear; % clear variables
clc; % clear command window
close all
%example 2.4.1%
%Define the vector field
syms x y z
F = [x-y,x+y,z+2*x];
 % given vector field
% Define path in its parametric form
syms t real
 % parameter t
R1 = [t,2*t,5*t]
 % parametrization R(t)
a = 0; b = 1;
 % interval for t
%Work done by the vector field
FR = subs(F,{x,y,z},{R1(1),R1(2),R1(3)}) % in F substitute parametrization R for x,y,z
Rp = diff(R1,t)
 % R’(t)
W1 = int(dot(FR,Rp),t,a,b)


%example 2.4.2%
%Define the vector field
syms x y z
F = [x-y,x+y,z+2*x];
 % given vector field
G = curl(F) ;
%example 2.4.2
% Define path in its parametric form
syms t real
 % parameter t
R2 = [t,2*t,5*t^2]
 % parametrization R(t)
a = 0; b = 1;
 % interval for t
%Work done by the vector field
FR = subs(F,{x,y,z},{R2(1),R2(2),R2(3)}) % in F substitute parametrization R for x,y,z
Rp = diff(R2,t)
 % R’(t)
W2 = int(dot(FR,Rp),t,a,b)


%example 2.4.3%
%Define the vector field
syms x y z
F = [x-y,x+y,z+2*x];
 % given vector field
% Define path in its parametric form
syms t real
R3 = [2*cos(t),2*sin(t),1]
a = 0; b = 2*pi;
% parameter t
% parametrization R(t)
% interval for t
%Work done by the vector field
FR = subs(F,{x,y,z},{R3(1),R3(2),R3(3)}); % in F substitute parametrization R for x,y,z
Rp = diff(R3,t);
 % R’(t)
W3 = int(dot(FR,Rp),t,a,b)


%% Task 6.2
% Altered from lecture notes
clear; % clear variables
clc; % clear command window
close all
%Define the vector field
syms x y z
F = [x-y,x+y,z+2*x];
 % given vector field
% Define path in its parametric form
syms t real
 % parameter t
R4 = [t,2*t,5*t]
 % parametrization R(t)
a = 0; b = 5;
 % interval for t
%Work done by the vector field
FR = subs(F,{x,y,z},{R4(1),R4(2),R4(3)}); % in F substitute parametrization R for x,y,z
Rp = diff(R4,t);
 % R’(t)
W4 = int(dot(FR,Rp),t,a,b)

%% Task 6.3
% Altered from lecture notes
clear; % clear variables
clc; % clear command window
close all
%Define the vector field
syms x y z
F = [x-y,x+y,z+2*x];
 % given vector field
% Define path in its parametric form
syms t real
 % parameter t
R5 = [t+3.*(cos(2.*pi.*t./5)+1),2*t + 3.*(sin(2.*pi.*t./5)+1),5*t]
 % parametrization R(t)
a = 0; b = 5;
 % interval for t
%Work done by the vector field
FR = subs(F,{x,y,z},{R5(1),R5(2),R5(3)}); % in F substitute parametrization R for x,y,z
Rp = diff(R5,t);
 % R’(t)
W5 = int(dot(FR,Rp),t,a,b)

%% Task 6.4
% Altered from given file
clear; % clear variables
clc; % clear command window
close all

% The vector field F = [x-y,x+y,z+2x]
F = @(x) [x(1)-x(2); x(1)+x(2); x(3)+2*x(1)];
% Here x is a vector so x(1)='x', x(2)='y', x(3)='z'
syms t real
% interval for t
a = 0;
b = 5;

% The first path:
r1 = [t; 2*t; 5*t];
% Its tangent vector
dr1 = diff(r1,t);
% The work done
W1 = int(dot(F(r1),dr1),t,a,b);

% The second path
r2 = [t+3.*(cos(2.*pi.*t./5)+1);2*t + 3.*(sin(2.*pi.*t./5)+1);5*t];
% Its tangent vector
dr2 = diff(r2,t);
% The work done
W2 = int(dot(F(r2),dr2),t,a,b);

% plot the paths
subplot(1,2,1)
fplot3(r1(1),r1(2),r1(3),[a,b],'b')
xlabel('x'); ylabel('y'); zlabel('z'); %axis equal

hold on
fplot3(r2(1),r2(2),r2(3),[a,b],'r')

% The points at which to plot the vectors
T = a:0.1:b;

% The first curve
R1 = double(subs(r1,t,T));
% The first curve's tangent vectors
DR1 = double(subs(dr1,t,T));
quiver3(R1(1,:),R1(2,:),R1(3,:),DR1(1,:),DR1(2,:),DR1(3,:),0.2,'Color',[0 0 0.5])
% The vector field on the first curve
FR1 = double(subs(F(r1),t,T));
quiver3(R1(1,:),R1(2,:),R1(3,:),FR1(1,:),FR1(2,:),FR1(3,:),'Color',[0 0 0.5])

% The second curve
R2 = double(subs(r2,t,T));
% The second curve's tangent vectors
DR2 = double(subs(dr2,t,T));
quiver3(R2(1,:),R2(2,:),R2(3,:),DR2(1,:),DR2(2,:),DR2(3,:),0.2,'Color',[0.5 0 0])
% The vector field on the second curve
FR2 = double(subs(F(r2),t,T));
quiver3(R2(1,:),R2(2,:),R2(3,:),FR2(1,:),FR2(2,:),FR2(3,:),'Color',[0.5 0 0])

% the integrand for the first curve
FDR1 = double(subs(dot(F(r1),dr1),t,T));
subplot(1,2,2)
area(T,FDR1,'FaceColor','b','FaceAlpha',0.5)
xlabel('t'); ylabel('$\mathbf{F}\cdot\frac{d\mathbf{r}}{dt}$','Interpreter','latex');
hold on

% the integrand for the second curve
FDR2 = double(subs(dot(F(r2),dr2),t,T));
area(T,FDR2,'FaceColor','r','FaceAlpha',0.5)
legend(sprintf('W4=%d',W1),sprintf('W5=%.2f',W2))
hold off

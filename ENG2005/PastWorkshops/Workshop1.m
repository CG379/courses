ezplot('t^3-t',[-2,2])
hold on

syms x; ezplot(sin(x),[-2,2]);
hold on; ezplot(x/2,[-2,2]);
hold off

clear;

%% Double integrals
Func = @ (x,y) (x + cos (y) + 1);
I = integral2 (Func, 0, 1, 0, 2);

%% Factors
syms x;
factor(x^2-4)

%% Max and Min
clc; clear;
xf=-10:0.1:6;
y=xf.^3 + 5.7*xf.^2 - 35.1*xf + 85.176;
plot(xf,y), xlabel('x'),ylabel('y'), grid, title('y vs x');

[xmin,ymin] = fminbnd( @(x) (x^3+5.7*x^2-35.1*x+85.176),-10,6 );
fprintf('xmin=%7.3f ymin=%9.3f \n',xmin,ymin)
[xmax,ymax] = fminbnd( @(x) (x^-1),-10,6); Ymax=-ymax;
fprintf('xmax=%7.3f Ymax=%9.3f \n',xmax,Ymax);

%% Lets continue

%Let's save graphs into a pdf file named plot04.pdf
x = 0:0.5:10; % x values range from 1 to 10 in steps of 0.5
y = x.^2; % square each element in x array and store in y
% plot y vs. x
plot(x,y,'bo','MarkerFaceColor','b')
xlabel('x (m)') % label horizontal axis
ylabel('y (m^2)') % label vertical axis
title('y = x^2') % title
h = 4; % height of plot in inches
w = 6; % width of plot in inches
set(gcf, 'PaperSize', [w h]); % set size of PDF page
set(gcf, 'PaperPosition', [0 0 w h]); % put plot in lower-left corner
print ('-dpdf','plot04.pdf'); % save plot as pdf file
%print ('-dpdf','test.pdf'); % PDF file (vector)
%print ('-deps','test.eps'); % Encapsulated Postscript B&W (vector)
%print ('-depsc','test.eps'); % Encapsulated Postscript color (vector)
%print ('-dtiff','test.tiff'); % tiff file (bitmap)
%print ('-djpeg','test.jpg'); % JPEG file (bitmap)

%% Special Character plots

%Add labels
% independant var
t = 0:2e-8:2e-6;
% frequency 
fo = 1e6;
% dependant var
xout = sin(2*pi*fo*t);
% plot 
plot(t*1e6,xout);
% Title and lables
title('Plot of sin(2\pif_{o}t) for f_{o}=10^6 Hz');
xlabel('time (\museconds)');
ylabel('x_{out}(t)');
% display equation on graph
text(1.5,0.3,'\omega = 2\pi \times f_{o}');

%% Paramitisation of curves
clear
%let's plot a complex surface z=f(x,y)=y*sin(x)
[x,y]=meshgrid(linspace(-2*pi,2*pi));
z=y.*sin(x);
%plot it in 3D!
mesh(x,y,z)
hold on
%add two parametric curves r(t)=(x(t),y(t),z(t) ), -2 pi<t< 2pi,
% on the z surface
%X=t; Y=1+0*t; Z=sin(t);
%X2=pi/4+0*t; Y2=t; Z2=sqrt(2)/2*t;
%define t
t=linspace(-2*pi,2*pi);
%define X
X=t;
%define Y
Y=1+0*t;
%combine to generate Z
Z=sin(t);
%define another curve
X2=pi/4+0*t;
Y2=t;
Z2=sqrt(2)/2*t;
%plot the two curves with plot 3, add some colour
plot3(X,Y,Z,'LineWidth',2)
plot3(X2,Y2,Z2,'k','LineWidth',2)
hold off
xlabel('x'),ylabel('y'),zlabel('z')
% add a marker at the point of intersection
% you will define the position of the marker
%xp(t),yp(t),zp(t) then plot
hold on
xp=pi/4;
yp=1;
zp=sqrt(2)/2;
% do not forget to add a marker 'r*'
%can you change the type of marker and its colour?
plot3(xp,yp,zp,'r*','MarkerSize',10, 'LineWidth',2)
% add limits to the axes
axis([-5,5,-5,5,-5,5])
hold off
% remove the image if more plots are need after this


%% Kepler
clear % clear variables
clc % clear command window
e = 0.0004; % eccentricity
a = 1; % semi-major axis
N = 40; % number of points defining orbit
nTerms = 10; % number of terms to keep in infinite series defining
% eccentric anomaly
M = linspace(0,2*pi,N); % mean anomaly parameterizes time
% M varies from 0 to 2*pi over one orbit
alpha = zeros(1,N); % preallocate space for eccentric anomaly array
%%%%%%%%%%
%%%%%%%%%% Calculations & Plotting
%%%%%%%%%%
% Calculate eccentric anomaly at each point in orbit
for j = 1:N
% initialize eccentric anomaly to mean anomaly
alpha(j) = M(j);
% include first nTerms in infinite series
for n = 1:nTerms
alpha(j) = alpha(j) + 2 / n * besselj(n,n*e) .* sin(n*M(j));
end
end
% calculate polar coordiantes (theta, r) from eccentric anomaly
%this is celestial mechanics
theta = 2 * atan(sqrt((1+e)/(1-e)) * tan(alpha/2));
r = a * (1-e^2) ./ (1 + e*cos(theta));
% plot radius versus theta
plot(theta,r)
%hmmmm not a useful graph!
% polar a plot of orbit instead of cartesians
polar(theta,r,'bo');
% much better I can see the excentricity of the satellite
% Label plot with eccentricity
title(['Elliptical Orbit with e = ' sprintf('%.2f',e)]);
% Save plot as pdf
%set(gcf, 'PaperPosition', [0 2 8 8]);
%print ('-dpdf','kepler.pdf');
%print ('-dpng','kepler.png','-r300');


%% Task 1
clc % clear command window
clear % clear all variables
close all % close all graphics windows
%Find the Double Integral of f(x,y) using the MATLAB example above
%f(x,y)= x + y
%[‘x’ belongs [1,2] and ‘y’ belongs to [1,2]]
%Define a function f(x,y) = x+y, then integrate it as a double integral
Func = @ (x,y) (x + y);
%[Creating the function in ‘x’ and ‘y’]
I = integral2 (Func, 0, 1, 0, 2)
%[Calling the integral2 function and limits as 0 <= x <= 1; 0 <= y <= 2)]
%[Mathematically, the double integral of x + cos (y) + 1 is 3.9093]

%% Maxima and Minima
clc; clear;
% First, plot the function so that we can determine the x range to use
% in fminbnd. Let us assume that the relative minimum lies between
% x1=-10, x2=6.
xf=-10:0.1:6;
y=xf.^3 + 5.7*xf.^2 - 35.1*xf + 85.176;
plot(xf,y), xlabel('x'),ylabel('y'), grid, title('y vs x');
% Next, find the minimum and maximum using MATLAB's anonymous
% function method directly in the fminbnd function.
[xmin,ymin] = fminbnd( @(x) (x^3+5.7*x^2-35.1*x+85.176),-10,6 ); 
fprintf('xmin=%7.3f ymin=%9.3f \n',xmin,ymin)
% Note: To find a maximum, instead of a minimum of the
% negative of the function.
[xmax,ymax] = fminbnd( @(x) -(x^3+5.7*x^2-35.1*x+85.176),-10,6); Ymax=-ymax; %
% Print results
fprintf('xmax=%7.3f Ymax=%9.3f \n',xmax,Ymax)

%% Kepler
clear % clear variables
clc % clear command window
e = 0.9; % eccentricity
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


%Run the KeplerEquation code and change the exccentricity
%of the planet to 0.4, 0.7, 0.9 each time.
%What happens to the planet ?

% Explination:
% The higher the eccentricity, the more eliptical the orbit becomes. It
% starts to skeew to the 180 side of the graph. 


%% Task 4
%%Create a polar plot of r(t)=(t, sin(t)*cos(t)) for a full 2pi rotation.
%Then can you retain only one "petal" (loop)?

t = 0:0.01:pi/2; % Change / to * to get full rotation
r = (sin(t) .* cos(t));

polarplot(t, r)


%% Task 5
% tidy-up your workspace
clc % clear command window
clear % clear all variables
close all % close all graphics windows
% define the period of the signal
period = 5;
% 200 data points evenly spaced over 1 period
t = linspace(0,period,200);
% create a sine wave sin(2*pi/period*t) and add Gaussian noise to it
y = @(x) (sin(2*pi/period.*t));

noise = randn(1,length(t));

signal = y(t) + noise;

% plot as blue data points
plot(t,signal,"bo")
% prevent future plots from overwriting current plot
hold all
% create a sine wave with no noise and plot as red curve
plot(t, y(t),"r");
% label axes and add a legend for the two sine plots :'sine + noise','sine'
legend("Signal with noise", "Signal")
xlabel("x");
ylabel("sin(2*pi/5*t)");
title("Signal vs Noisy Signal")
% save the plot as a png file : name it sines.png
h = 4; % height of plot in inches
w = 6; % width of plot in inches
set(gcf, 'PaperSize', [w h]); % set size of PDF page
set(gcf, 'PaperPosition', [0 0 w h]); % put plot in lower-left corner
print ('-dpdf','plot07.pdf'); % save plot as pdf file
%print ('-dpng','?'); % save plot as pdf file

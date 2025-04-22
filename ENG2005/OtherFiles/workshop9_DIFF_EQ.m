
%% DIFFERENTIAL EQUATIONS MATLAB INVESTIGATION 
%a similar example with 5.40/404 glynjames
%x"+4x'+x=f(t) differential equation with an impulse external force
%f(t)=1 , T<=3, 0 for t >=3 the external force is a step function

clear all; clc
%% Define symbolic variables
syms s t y(t) Y(s) 
D1y = diff(y);
D2y = diff(D1y);
%% Dynamical system : define it 
Eqn = D2y+4*D1y + 1*y == heaviside(t)-heaviside(t-3)
%% Perform Laplace Transform of Eqn
LEqn = laplace(Eqn);
% Substitute Laplace transform of y(t) for Y(s), and y(0) for the initial condition
LEqn = subs(LEqn, {laplace(y(t), t, s), y(0),D1y(0)}, {Y(s), 0,2});
% Isolate Y(s) in LEqn
LEqn = isolate(LEqn, Y(s))
%% Perform inverse Laplace transform on the right-hand side of LEqn
y(t) = ilaplace(rhs(LEqn))
%% Plot the solution
fplot(@(t) y(t), [0 10])
grid on

xlabel('Time, t')
ylabel('y(t)')
grid on
legend('y(t)','Location','best')

%%


%% ANSWERS & COMMENTS

% # Question 1
% The results show...

% # Question 2
% The results show...

% # Question 3
% The results show...



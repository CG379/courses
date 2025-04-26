
%% DIFFERENTIAL EQUATIONS MATLAB INVESTIGATION 
%a similar example with 5.40/404 glynjames
%x"+4x'+x=f(t) differential equation with an impulse external force
%f(t)=1 , T<=3, 0 for t >=3 the external force is a step function

%% 5a. 1-2
clear; % clear variables
clc; % clear command window
close all

% Define symbolic variables
syms s t y(t) Y(s) yh(t) Yh(t)
D1y = diff(y);
D2y = diff(D1y);

% Dynamical system : define it 
Eqn = D2y+5*D1y + 6*y == 3*heaviside(t)- 3*heaviside(t-6)
% Homogeneous equation
Eqnh = D2y+5*D1y + 6*y == 0

% Perform Laplace Transform of Eqn
LEqn = laplace(Eqn);
LEqnh = laplace(Eqnh);
% Substitute Laplace transform of y(t) for Y(s), and y(0) for the initial condition
LEqn = subs(LEqn, {laplace(y(t), t, s), y(0),D1y(0)}, {Y(s), 0,2});
LEqnh = subs(LEqnh, {laplace(y(t), t, s), y(0),D1y(0)}, {Yh(s), 0,2});
% Isolate Y(s) in LEqn
LEqn = isolate(LEqn, Y(s));
LEqnh = isolate(LEqnh, Yh(s));

% Perform inverse Laplace transform on the right-hand side of LEqn
y(t) = ilaplace(rhs(LEqn))
yh(t) = ilaplace(rhs(LEqnh))

% Plot the solution
fplot(@(t) y(t), [0 10])
hold on
grid on
fplot(@(t) yh(t), [0 10])
xlabel('Time, t')
ylabel('y(t)')
grid on
legend('y(t)', 'yh(t)','Location','best')

%% 5a. 3 Explination
% The homogeneous solution is an exponential function with lambda = -2 and
% -3. The solution with the forcing function still contains exponentials
% but its magnitude is larger and between t = 4 and t = 6, the function is
% constant at 0.5.


%% 5a. 4
clear; % clear variables
clc; % clear command window
close all

syms s t y(t) Y(s) 
D1y = diff(y);
D2y = diff(D1y);

% Dynamical system : define it 
Eqn = D2y+4*D1y + 6*y == 3*heaviside(t)-3*heaviside(t-3);

% Perform Laplace Transform of Eqn
LEqn = laplace(Eqn);
% Substitute Laplace transform of y(t) for Y(s), and y(0) for the initial condition
LEqn = subs(LEqn, {laplace(y(t), t, s), y(0),D1y(0)}, {Y(s), 1,2});
% Isolate Y(s) in LEqn
LEqn = isolate(LEqn, Y(s));

% Perform inverse Laplace transform on the right-hand side of LEqn
y(t) = ilaplace(rhs(LEqn))

% Plot the solution
fplot(@(t) y(t), [0 10])
grid on

xlabel('Time, t')
ylabel('y(t)')
grid on
legend('y(t)','Location','best')

%% 5a. 4 Explination
% Compared to the previous solution, the fuction cap is now lower down the
% equation. This solution also decreases faster than the above solution.

%% 5a. 6
clear; % clear variables
clc; % clear command window
close all

% Define symbolic variables
syms s t y(t) Y(s) yh(t) Yh(t)
D1y = diff(y);
D2y = diff(D1y);

% Dynamical system : define it 
Eqn = D2y+5*D1y + 6*y == heaviside(t)- heaviside(t-6)
% Homogeneous equation
Eqnh = D2y+5*D1y + 6*y == 0

% Perform Laplace Transform of Eqn
LEqn = laplace(Eqn);
LEqnh = laplace(Eqnh);
% Substitute Laplace transform of y(t) for Y(s), and y(0) for the initial condition
LEqn = subs(LEqn, {laplace(y(t), t, s), y(0),D1y(0)}, {Y(s), 0,2});
LEqnh = subs(LEqnh, {laplace(y(t), t, s), y(0),D1y(0)}, {Yh(s), 0,2});
% Isolate Y(s) in LEqn
LEqn = isolate(LEqn, Y(s));
LEqnh = isolate(LEqnh, Yh(s));

% Perform inverse Laplace transform on the right-hand side of LEqn
y(t) = ilaplace(rhs(LEqn))
yh(t) = ilaplace(rhs(LEqnh))

% Plot the solution
fplot(@(t) y(t), [0 10])
hold on
grid on
fplot(@(t) yh(t), [0 10])
xlabel('Time, t')
ylabel('y(t)')
grid on
legend('y(t)', 'yh(t)','Location','best')

%% 5a. 6 Explination
% The homogeneous solution is the same homogeneous solution as in part 1,
% with different constants. The overall solution is similar to the one in
% part 1 but with a lower magnitude.

%% 5a. 7 Explination
% for all solutions, as t approaches infinity the solutions will approach
% 0.

%% 5b. 1
clear; % clear variables
clc; % clear command window
close all

syms s t y(t) Y(s) 
D1y = diff(y);
D2y = diff(D1y);

% Dynamical system : define it 
Eqn = D2y+3*D1y + 2*y == 1+dirac(t-4)

% Perform Laplace Transform of Eqn
LEqn = laplace(Eqn);
% Substitute Laplace transform of y(t) for Y(s), and y(0) for the initial condition
LEqn = subs(LEqn, {laplace(y(t), t, s), y(0),D1y(0)}, {Y(s), 0,2});
% Isolate Y(s) in LEqn
LEqn = isolate(LEqn, Y(s))

% Perform inverse Laplace transform on the right-hand side of LEqn
y(t) = ilaplace(rhs(LEqn))

% Plot the solution
fplot(@(t) y(t), [0 10])
grid on

xlabel('Time, t')
ylabel('y(t)')
grid on
legend('y(t)','Location','best')

%% 5b. 2 Explination
% Before t = 4, the system follows a solution determined by the homogeneous 
% part of the equation, and at t = 4, the system experiences a sudden change 
% in its behavior due to the impulse function. 

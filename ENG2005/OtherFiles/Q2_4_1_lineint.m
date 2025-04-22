%%
%example 2.4.1
%Define the vector field 
syms x y z
F = [x-y,x+y,z+2*x];                    % given vector field

% Define the path in its parametric form
syms t real                             % parameter t
R = [t,2*t,5*t];                        % parametrization R(t)
a = 0; b = 5;                           % interval for t

%Work done by the vector field
FR = subs(F,{x,y,z},{R(1),R(2),R(3)});  % in F substitute parametrization R for x,y,z
Rp = diff(R,t);                         % R'(t)
W = int(dot(FR,Rp),t,a,b) 
%%
%example 2.4.2
%Define the vector field 
syms x y z
F = [x-y,x+y,z+2*x];                    % given vector field

% Define the path in its parametric form
syms t real                             % parameter t
R = [t,2*t,5*t^2];                      % parametrization R(t)
a = 0; b = 1;                           % interval for t

%Work done by the vector field
FR = subs(F,{x,y,z},{R(1),R(2),R(3)});  % in F substitute parametrization R for x,y,z 
Rp = diff(R,t);                         % R'(t)
W = int(dot(FR,Rp),t,a,b) 

%%
%example 2.4.3
%Define the vector field 
syms x y z
F = [x-y,x+y,z+2*x];                    % given vector field 

% Define the path in its parametric form
syms t real                             % parameter t
R = [2*cos(t),2*sin(t),1];              % parametrization R(t)
a = 0; b = 2*pi;                        % interval for t

%Work done by the vector field
FR = subs(F,{x,y,z},{R(1),R(2),R(3)});  % in F substitute parametrization R for x,y,z
Rp = diff(R,t);                         % R'(t)
W = int(dot(FR,Rp),t,a,b) 



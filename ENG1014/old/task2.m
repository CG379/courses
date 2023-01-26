% Campbell Gregor
% Last modified: 27/7
% 33110018

clc; clear all; close all;


% Lab 1 
% Task 2

A = 10:10:100;

Alinespace = linspace(10,100,10);
%plot(A);

third = A(1:3:end);
A5 = [A;A;A;A;A];

B = [1:4;5:8;9:12];
eight = B(2,4);
B(3,2) = 20;

data = B([2,3],[2,4]);

C = [1,1,3,4;5,6,4,8;9,1,5,4];

D = B * transpose(C);

E = C.*B;

% Task 4

disp(energy(9));
disp(energy(5.9));


% Task 5
[dist,speed] = drift(600,4);
disp(dist);
disp(speed);

%{
Clear all; close all; clc;
v = (1/vo^2 + 0.8*t)^(-0.5);
s= ((sqrt(1/v0^2 + 0.8*t)-(1/v0))/(1/0.4);
t=4;
v0= 600;

Errors in above code:
1. vo intread of v0
2. Extra "("
3. Values of v0 and t referenced before assignment

%}

% Functions used
function [l,v] = drift(v0, t)
v = (1/v0^2 + 0.8*t)^(-0.5);
l = (sqrt(1/v0^2 + 0.8*t)-(1/v0))/(1/0.4);
end

function E = energy(M)
E = 10^(4.4 + 1.5*M);
end










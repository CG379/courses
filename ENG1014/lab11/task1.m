% Campbell Gregor
% Last modified: 19/10/22
% 33110018

clc; clear all; close all;

f = @(t,y) 3.*exp(t) - 7.*y./4;

tspan = [0,3];

y0 = 3;
h = 1;



[t1,y1] = heun(f,tspan,y0,h)

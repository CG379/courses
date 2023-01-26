% Campbell Gregor
% Last modified: 12/9/22
% 33110018

clc; clear all; close all;


m = [1.1, 1.7, 3.2, 4.1, 5.8, 7.6, 8.6];

a = [0.08, 0.11, 0.2, 0.28, 0.305, 0.308, 0.328];

[F, V, a0, a1, r2] = LinRegrSGR(m,a,2);
hold on;
plot(m,a,"rs");

fprintf("a = %.3f, a0 = %.3f, r2 = %.3f\n", a1,a0,r2);
% Model
a1 = @(F,V,m) F.^2 .* m.^2 ./ (V.^2 + m.^2);
m = 1:0.1:10;

plot(m, a1(F,V,m),"b--")
xlabel("m")
ylabel("a")
title("x vs a")



% Campbell Gregor
% Last modified: 9/9/22
% 33110018

clc; clear all; close all;

timeData = importdata("parameter-Vs-time.txt");


x = timeData.data(:,1);
y = timeData.data(:,2);

logy = log(y);

[a0,a,r2] = linreg(x,logy);

a = exp(a);

model = a .* exp(x.*a0);

plot(x,model)

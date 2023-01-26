% Campbell Gregor
% Last modified: 19/10/22
% 33110018

clc; clear all; close all;

system = [3,3,1,0; 0,0,1,2; 0,2,1,1/2; 0,-1,3,3/2];


answer = [10;7;9;13];

solutionsGJ = gauss_jordan(system,answer);

solutionsG = gauss(system,answer);

solutionsNG = naive_gauss(system,answer);

fprintf("Solutions:\n")
fprintf("x1: %.2f\nx2: %.2f\nx3: %.2f\nx4: %.2f\n",solutionsGJ);
fprintf("The nieve approach doesn't work since the matrix has 0 values preventing the upper triangle.\n")





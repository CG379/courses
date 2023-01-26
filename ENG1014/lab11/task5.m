% Campbell Gregor
% Last modified: 20/10/22
% 33110018

clc; clear all; close all;

A = [-1,0,2;
    -1/2,3/4,0;
    0,1/4,-1];

b = [0;1;0];

solutions = gauss_jordan(A,b);

fprintf("v1\tv2\tix\n");
fprintf("%.2fV\t%.2fV\t%.2fA\n",solutions);
% Campbell Gregor
% Last modified: 26/7
% 33110018

clc; clear all; close all;


A = linspace(0,10,11);

B = transpose(A);

square = zeros(3,2,2);

eye = eye(4,4);

C = zeros(4,4,4);

C(:,:,1) = eye;

C(:,:,2) = eye;

C(:,:,3) = eye;

C(:,:,4) = eye;


I = rand()* 32;
dice = floor(rand()*6+1);


D = [linspace(0,10,11);linspace(0,10,11)];

E = D(1:2);

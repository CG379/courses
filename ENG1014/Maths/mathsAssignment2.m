
clc; clear all; close all;


a0 = [1,0,0;0,1,0; 0,0,1];
a1 = [1/sqrt(3), -1/sqrt(2), -1/sqrt(6); 1/sqrt(3), 1/sqrt(2), -1/sqrt(6);1/sqrt(3),... 
    0, 2/sqrt(6)];

a12 =   [1/sqrt(3),1/sqrt(3),1/sqrt(3);...
        -1/sqrt(2),1/sqrt(2), 0;...
        -1/sqrt(6),-1/sqrt(6),2/sqrt(6)];

format rational;
[Eigenvectors,Eigenvalues] = eig(a1);

%5
trace = trace(a1);




% Q6

A = [21,16,31;10,10,20;28,33,38];
X = [89,94,99;100,110,105;82,82,102];

Ainv = inv(A);

B = X * Ainv;
Bt = transpose(B);

I = B*Bt;




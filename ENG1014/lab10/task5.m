% Campbell Gregor
% Last modified: 5/10/22
% 33110018

clc; clear all; close all;
b = 12;
a = 1;

maxError = 10^(-10);

f = @(x) (2 + x.^3 - cos(x))./(cos(x) + x.^3);

I13 = comp_simp13(f,a,b,3);
I38 = simp38(f,a,b);
fprintf("Simp 1/3 of f =%.3f\nSimp 3/8 of f = %.3f\n",I13,I38);

error = @(I1,I3) 2.*(abs(I1 - I3)./(I3 + I1)) .* 100;
i = 0;
j = 4;
k = 3;
e = error(I13,I38);
while e >= maxError
    I13 = comp_simp13(f,a,b,j);
    I38 = comp_simp38(f,a,b,k);
    j = j + 3;
    k = k + 2;
    i = i + 1;
    e = error(I38,I13);
end

fprintf("No. of Applications needed: %d\n 1/3 %.3f\n3/8 %.3f\nError %.3f\n",i,j,k,e);
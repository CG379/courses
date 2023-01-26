% Campbell Gregor
% Last modified: 21/9/22
% 33110018

clc; clear all; close all;


% Initial Values
 a = 0.8;
 b = 1.2;
 c = 2.9;
 d = 3.8;


Xo = 130;
XL = 130;
Xu = 167;
Xi =120;
pert = 0.01;
precision=1e-4;

theta2 = 30;

poly = (a^2 - b^2 + c^2 + d^2)/(2 * a * c);

t = 1:1:1000;
f = @(theta4) (d/a) .* cosd(theta4) - (d/c)*cosd(theta2) + poly ...
    - cosd(theta2 - theta4);


% roots
realRoot = fzero(f,Xo);

[biRoot, bi] = bisection(f,XL,Xu,precision);

[falseRoot, fi] = falseProp(f,XL,Xu,precision);

[modRoot, mi] = modsecant(f,Xi,pert,precision);


fprintf("Root\t\tBisection\tFalse Proposition\tMod Secant\n")
fprintf("%.4f %15.4f %20.4f %20.4f\n", realRoot,biRoot,falseRoot,modRoot)

% Accuracy
diff = @(x) abs(realRoot - x);

diffs = diff([biRoot,falseRoot,modRoot]);


% Plot
plot(bi, diffs(1), "ro", fi,diffs(2),"bo", mi, diffs(3),"ko")
xlabel("Itterations")
ylabel("Difference from actual root")
legend("Bisection Method", "False Proposition Mthod", "Modified Secant", ...
    "Location","northwest")












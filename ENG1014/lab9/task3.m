% Campbell Gregor
% Last modified: 20/9/22
% 33110018

clc; clear all; close all;

x = 0:1:550;

L = 550;
prec = 10^(-6);
E = 57000;
I = 31000;
w0 = 3.2;

% Get derivatives
f = @(x) (w0/(120 * E * I * L)) .* (-x.^5 + 2.*L^2 .* x.^3 - L^4 .* x);
df = @(x) (w0/(120 * E * I * L)) .* (-5.* x.^4 + 6 .* L^2 .* x.^2 - L^4);
ddf = @(x) (w0/(120 * E * I * L)) .* (-20 .* x.^3 + 12 .* L^2 .* x);

root = NewtRaph(df,200,ddf,prec);

% Plot
subplot(2,1,1);
plot(x, df(x), root,df(root),"r^");
grid on;
xlabel("x (cm)");
ylabel("Deflection Gradient");
title("Derivative of Beam deflection")


subplot(2,1,2)
plot(x, f(x), root,f(root),"r^");
xlabel("x (cm)");
ylabel("Deflection (cm)");
title("Deflection of Beam")
grid on;

maxDef = f(root);

fprintf("The maximum deflection of %1.2f cm occurs at %3.2f cm.\n", maxDef, root);


% Campbell Gregor
% Last modified: 5/10/22
% 33110018

clc; clear all; close all;


g = 9.81;
rho = 999;
ht = 10;
rt = 2.2;

r = @(h) (rt / ht).*(ht - h);

FPM = @(h) g .* rho .* pi .* (r(h)).^2;

F = @(h) h.* FPM(h);

W = integral(F,0,ht);

%% Plotting

h = 0:0.1:ht;

plot(h,F(h));
xlabel("Height of water (m)");
ylabel("Force (N)");
title("Force vs Height of the water");

fprintf("Energy: %.3f kJ\n", W/1000);

%% Error cals

error = @(Ws) 2.*(abs(W - Ws)./(W + Ws)) .* 100;

% Segments for simp 1/3
for n = 3:2:10000
    Wi = comp_simp13(F,0,ht,n);
    e = error(Wi);
    if e <= 0.01
        break
    end
end

fprintf("No. of Points Simp 1/3: %d\n",n);
% error is farily low, this is expected since that overall equation is a
% polynomial. This can be approximated well by simp 1/3.


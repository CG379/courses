% Campbell Gregor
% Last modified: 21/9/22
% 33110018

clc; clear all; close all;

Pcend = 80000;
Pcstart = 100000; 
kc = 0.055;

Psend= 320000;
Psstart=10000; 
ks=0.083;

pc = @(t) Pcend .* exp(-kc .* t) + Pcstart;

ps = @(t) (Psend)./(1 + ((Psend/Psstart) - 1) .* exp(-ks .* t));


% When ps(t) = 1.2 * pc(t), ps(t) - 1.2pc(t) = 0

p20 = @(t) ps(t) - 1.2 .*pc(t);
root = bisection(p20,10,90,1000);

t = 0:1:100;

plot(t,p20(t), root, p20(root), "r^");
xlabel("Time (years)")
ylabel("Population Different (ps-1.2pc)")
title("Polulation difference of City and Suburb")


% Printing to screen

fprintf("In year %.0f, the suburbs are 20%% larger than the city.\n" + ...
    "The city population is %.0f and the suburb population is %.0f.\n", root, pc(root), ps(root));




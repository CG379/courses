% Campbell Gregor
% Last modified: 2/9/22
% 33110018

clc; clear all; close all;

% Cyliner torso 
h = 0.08;
r1 = 0.02;

% Arm cylinders
r2 = 0.001;
l = 0.04;
% Position from ground on torso 
s = 0.07;

massTotal = 1;
u = 0.1;

% String Height 
w = 0.05;

% Froce
P = 10;
g = 9.81;
weightForce = g * massTotal;

% Find Volume
volumeBody = pi * r1^2 * h;
volumeHead = 0.5 * (4/3) * pi * r1^3;
volume1Arm = pi * r2^2 * l;

volume = volume1Arm * 2 + volumeHead + volumeBody;

density = massTotal/volume;

% Find Mass
mHead = density * (volumeHead);
mBody = density * (volumeBody);
m1Arm =  density * (volume1Arm);

% Find I
IHead = (2/5) * mHead * r1^2;
IBody = (1/2) * mBody * r1^2;
I1Arm = ((1/12) * m1Arm * l^2) + (m1Arm * (l/2 + r1)^2);
totalI = IHead + IBody + 2 * I1Arm;

% Use Values above to find alpha
tFriction = (2/3) * r1 * u * weightForce;
tApplied = P * r1; 



% Find rot acc for both acceleration and dcelleration, assumed constant
alphaStart = tApplied/totalI;
alphaEnd = -tFriction/totalI;

% Acceleration calculations
rotDisp = 0:0.1:(3 * 2 * pi);

% s = u*t + 0.5 * a * t^2, u=0
t1 = sqrt(2 .* rotDisp ./ alphaStart);

% v^2 = u^2 + 2 * a * s, u=0 
w0d = sqrt(2 * alphaStart * rotDisp(end));

% v1 = u2
% Deceleration Calculations

% v^2 = u^2 + 2 * a * s, v = 0
finalDisp = (-(w0d^2)/(2 * alphaEnd)) + rotDisp(end);

rotDisp2 = rotDisp(end):0.1:finalDisp + rotDisp(end);

 
% s = 0.5 * (v+u) * t
%t2 = rotDisp2 .* 2 ./(w0d);

% s = u * t + 0.5 * a * t^2
%t2 = (-w0d +/- sqrt(w0d^2 - (4* 0.5 * alphaEnd .* rotDisp2))./(alphaEnd)) + t1(end);

% s = v * t - 0.5 * a * t^2
t2 = sqrt(-2 .* (rotDisp2-rotDisp(end))./alphaEnd) + t1(end);

% I realise this produces the wrong shape of graph, but i can't seem to
% calculate the right time value


%% Graphing
hold on;
plot(t1, rotDisp./(2 * pi), "b");

plot(t2, rotDisp2./(2 * pi), "r")
xlabel("Time (s)")
ylabel("No. of Rotations")
title("Justaway rotations over time")
hold off;













%{

tDiskApplied = r1 * P;
tTotal = tDiskApplied - tDiskFriction;
IDisk = massTotal * r1^2 /2;
accRadial = tTotal/IDisk;
%}





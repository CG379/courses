% Campbell Gregor
% Last modified: 17/8/22
% 33110018

clc; clear all; close all;

%% import data 

distancePlanets =  importdata("distances.txt");

planets = string(distancePlanets.textdata(2:end,1));

distance = distancePlanets.data(1:end,1);

orb = distancePlanets.data(1:end,2);

accR = (orb.^2) ./ (distance .* 100);
%% plot datas
plot(distance, accR, "b-");
xlabel("Distance (km)")
ylabel("Radial Acceleration (m/s^2)")
title("Distance vs Radial Acceleration in Planets")


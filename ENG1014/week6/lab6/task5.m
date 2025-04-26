% Campbell Gregor
% Last modified: 31/8/22
% 33110018

clc; clear all; close all;

xLocation = [1,5,8,11,17,22];
yLocation = [25,15,18,3,23,4];
volume = [3,4,2,5,8,3];
%% Calculate values
distance = round(sqrt((xLocation.^2) + (yLocation.^2)));

cost = 0.5 .* distance .* volume;
[minVal, minSupplier] = min(cost);

%% Plots
hold on;
plot(xLocation,yLocation,"ko", markerfacecolor = "k")
plot(xLocation(minSupplier),yLocation(minSupplier),"d", markerfacecolor = "r")
hold off;


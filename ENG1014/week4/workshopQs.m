% Campbell Gregor
% Last modified: 12/8/22
% 33110018

clc; clear all; close all;

%% Anon functions
F =@(x) 3.*x.^5 + 6.*x.^4 - 12.*x.^3 + 2.*x.^2 - x.*10 + 17;

a = [F(0), F(1), F(-1),F([-1 0 1])];

G = @(x,y,z) exp(y) .* sin(x) + rem(z,2);

b = [G(0,0,0), G(pi/2,1,3)];

%% Importing data
%{
data = importdata("long_jump_records.txt");
values = data.data;

rankNum = values(1,:);
distance = values(2,:);
windSpeed = values(3,:);

[highestSpeed, rank] = max(windSpeed);

figure(1);
plot(rankNum,distance,"b",rank,distance(rank),"d");
xlabel("Rank #")
ylabel("Distance (m)")
title("Rank vs Distnce Jumped")
legend("Distance", "Highest wind speed")

figure(2)
plot(rankNum,windSpeed,"r");
xlabel("Rank #")
ylabel("Wind speed (m/s)")
title("Rank vs Wind speed")
%}



%% Sunflower

seed = linspace(0,1000,1000);
xPosition = @(n, d) sqrt(n).* cos(seed.*d.*(pi / 180));
yPosition = @(n, d) sqrt(n).* sin(seed.*d.*(pi / 180));
d = [60,91.6,137.5];
plot(xPosition(seed,d(3)),yPosition(seed,d(3)),"r");
grid on;

%% Torus
torusData = importdata("torus_data.txt");
a = torusData.data(:,1);
b = torusData.data(:,2);
V = torusData.data(:,3);
SA = torusData.data(:,4);



%% Functions

[t,c] = volume([1,2],[2,3],[3,4],[4,5]);

function [volume, cost] = volume(h,b,l,c)
% Written by: Campbell Gregor, 33110018
% Last edited: 12/8/22
% Calculates the volume of a rectangular prism and the cost to paint the
% surface area
% Inputs: (length in m, base in m, hight in m, cost per square m to paint)
% Outputs: (volume in m^3, cost to paint in $)
volume = l .* b .* h;
cost = c.*(2 .* l.*h + 2 .* h.*b + 2 .* l.*b);
end




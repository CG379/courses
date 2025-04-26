% Campbell Gregor
% Last modified: 31/8/22
% 33110018

clc; clear all; close all;


m_kids = [15, 30, 23, 21, 24, 41, 22, 29, 30, 25];
r_kids = [1.8, 1.6, 1.5, 1.5, 1.4, 1.85, 1.5, 1.4, 1.6, 1.2];


m = 60;
r1 = 1.9;
f = 350;
t = f * r1;

disk = m * r1^2 /2;
firstKid = 25*1.3^2;
inertia = 25*1.3^2 + disk;
originalA = t / inertia;



%% Calculate Acceleration Values

for i = 1:length(r_kids)
    inertia = inertia + (m_kids(i) * r_kids(i)^2);
    acc(i) = t/inertia;
    if acc(i) > 1
        % Add original son of dad
        maxKid = i + 1;
    end
end
% Add original acceleration to list
acc = [originalA, acc];
fprintf("Max Kids = %d", maxKid);

%% Plot

plot(1:length(acc), acc, "bo-");
xlabel("No. of Kids");
ylabel("Rotational Acceleration");
title("Merry-go-round Acceleration");


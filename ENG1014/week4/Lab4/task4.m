% Campbell Gregor
% Last modified: 18/8/22
% 33110018

clc; clear all; close all;

labData = importdata("Lab_data.xlsx");

%% Importiong dataset a
experiments = labData.data;

angle = [experiments(end,1); experiments(end-1,1); experiments(1:end - 2,1)];


flat = [experiments(end,2); experiments(end-1,2); experiments(1:end - 2,2)];

sym = [experiments(end,3); experiments(end-1,3); experiments(1:end - 2,3)];

cambered = [experiments(end,4); experiments(end-1,4); experiments(1:end - 2,4)];
%% Cd calculation
rho = 1.205;
v = 25;
s = 0.02011;

dragFlat = drag_calc(flat,rho,v,s);
dragSym = drag_calc(sym,rho,v,s);
dragCambered = drag_calc(cambered,rho,v,s);

%% Plotting Cd
plot(angle,dragFlat,"bv-");
hold on;
plot(angle,dragSym,"ro-");
plot(angle,dragCambered,"gs-");
hold off;
grid on;
title("Impact of Angle of Attack on the Drag Coeficient")
xlabel("Angle of Attack (degrees)");
ylabel("Drag Coeficient")
legend("Flat Plate", "Symetric", "'Cambered", "location", "best");

%% Calculating the min of each

[flatMinDrag,flatIndex] = min(dragFlat);

[symMinDrag, symIndex] = min(dragSym);

[CamberedMinDrag,CamberedIndex] = min(dragCambered);

flatMinDeg = angle(flatIndex);

symMinDegree = angle(symIndex);

CamberedMinDegree = angle(CamberedIndex);

%% Printing to the user

fprintf("Aerofoil Type \t Minimum Drag Coeficient \t Angle of Attack \n");
fprintf("Flat-plate \t \t %1.3f\t\t\t\t %d\n", flatMinDrag, flatMinDeg);
fprintf("Symmetric\t\t %1.3f \t\t \t\t %d\n", symMinDrag, symMinDegree);
fprintf("Cambered\t\t %1.3f\t\t\t\t %d\n", CamberedMinDrag, CamberedMinDegree);

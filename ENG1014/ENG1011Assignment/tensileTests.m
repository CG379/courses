% Campbell Gregor
% Last modified: 12/9/22
% 33110018

clc; clear all; close all;


PLAData = importdata("PLA_TeamT18.txt");
AlData = importdata("Al_T18.txt");
PeData = importdata("HDPE_TeamT18.txt");
AcData = importdata("acrylic.csv");


dataPLA = PLAData.data;
dataAL = AlData.data;
dataPE = PeData.data;
% Clean up data
dataPLA = dataPLA(1:486, :);

dataAC = AcData.data;

% Find Max of all
[maxPLA , IndexPLA] = max(dataPLA(:,1));
[maxAL , IndexAL] = max(dataAL(:,1));
[maxPE , IndexPE] = max(dataPE(:,1));
[maxAC,IndexAC] = max(dataAC(:,1));

% Finding Young's Modulus
PLAFlat =[31.835,0.011276];
ALFlat = [30.779, 0.00048144];
PEFlat = [16.251, 0.016168];
ACFlat = [10.041, 0.002611];


PLAModulus = PLAFlat(1)/PLAFlat(2);
ALModulus = ALFlat(1)/ALFlat(2);
PEModulus = PEFlat(1)/PEFlat(2);
ACModulus = ACFlat(1)/ACFlat(2);

% Yield Strength
ALYield = [67.278, 0.0067325];
PLAYield = [46.383, 0.019254];
PEYield = [25.521, 0.046885];
ACYield = [47.082, 0.015334];

% 0.2% offset

ofsetValuePLA = PLAYield(2) + 0.002;
ofsetValueAL = ALYield(2) + 0.002;
ofsetValuePE = PEYield(2) + 0.002;
ofsetValueAC = ACYield(2) + 0.002;

% Found the stress (x-axis) value, need to find the y-axis one, then plug
% Draw line from 0.002 to that point for 0.2% 
[c1, indexPLA2] = min(abs(dataPLA(:,2)-ofsetValuePLA));
[c2, indexAL2] = min(abs(dataAL(:,2)-ofsetValueAL));
[c3, indexPE2] = min(abs(dataPE(:,2)-ofsetValuePE));
[c4, indexAC2] = min(abs(dataAC(:,2)-ofsetValueAC));

PLAPoints = [dataPLA(indexPLA2,1), dataPLA(indexPLA2,2);0,0.002];

PEPoints = [dataPE(indexPE2,1), dataPE(indexPE2,2); 0,0.002];

ALPoints = [dataAL(indexAL2,1), dataAL(indexAL2,2);0,0.002];

ACPoints = [dataAC(indexAC2,1),dataAC(indexAC2,2);0,0.002];


% Ductility
PLADuctility = (dataPLA(end,2) - PLAYield(2)) * 100;
ALDuctility = (dataAL(end,2) - ALYield(2)) * 100;
PEDuctility = (dataPE(end,2) - PEYield(2)) * 100;
ACDuctility = (dataAC(end,2) - ACYield(2)) * 100;

% ((y- y1)/m) + x1 = x


% Plot
figure(1);
hold on;
plot(dataPLA(:,2), dataPLA(:,1));
plot(dataPLA(IndexPLA,2),maxPLA, "r^")
plot(PLAYield(2),PLAYield(1), "b^")
plot(PLAPoints(:,2), PLAPoints(:,1), "ko--")

xlabel("Strain");
ylabel("Stress (MPa)");
title("PLA");
legend("Stress-Strain Cruve", "Ultimate Tensile Strength", "Yield Strength", "0.2% Proof Stress", "Location", "northwest")

hold off;


figure(2);
hold on;
plot(dataAL(:,2), dataAL(:,1));
plot(dataAL(IndexAL,2),maxAL, "r^")
plot(ALYield(2),ALYield(1), "b^")
plot(ALPoints(:,2), ALPoints(:,1), "ko--")



xlabel("Strain");
ylabel("Stress (MPa)");
title("Aluminium");
legend("Stress-Strain Cruve", "Ultimate Tensile Strength", "Yield Strength", "0.2% Proof Stress", "Location", "southeast")
hold off;


figure(3);
hold on;
plot(dataPE(:,2), dataPE(:,1));
plot(dataPE(IndexPE,2),maxPE, "r^")
plot(PEYield(2),PEYield(1), "b^")
plot(PEPoints(:,2), PEPoints(:,1), "ko--")


xlabel("Strain");
ylabel("Stress (MPa)");
title("HDPE");
legend("Stress-Strain Cruve", "Ultimate Tensile Strength", "Yield Strength", "0.2% Proof Stress", "Location", "southeast")
hold off;

figure(4);
hold on;
plot(dataAC(:,2), dataAC(:,1));
plot(dataAC(IndexAC,2),maxAC, "r^")
plot(ACYield(2),ACYield(1), "b^")
plot(ACPoints(:,2), ACPoints(:,1), "ko--")


xlabel("Strain");
ylabel("Stress (MPa)");
title("Acrylic");
legend("Stress-Strain Cruve", "Ultimate Tensile Strength", "Yield Strength", "0.2% Proof Stress", "Location", "southeast")
hold off;








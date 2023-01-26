% Campbell Gregor
% Last modified: 9/9/22
% 33110018

clc; clear all; close all;


crystalData = importdata("Aluminium-VolumeVsVacancies.txt");

vac = crystalData.data(:,1);
VV0 = crystalData.data(:,2);

plot(vac,VV0, "r.","MarkerSize",30);

format default;

[a,b,r2] = linreg(vac,VV0);


fprintf("The equation is V/V_0 = %1.3f - %1.3f[vac]\n", b,-a)
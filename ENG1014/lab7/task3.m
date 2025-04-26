% Campbell Gregor
% Last modified: 5/9/22
% 33110018

clc; clear all; close all;

mass = 1.38;
v0=5.2;
angle = 31;
rampLength = 1.5;

%% Calculate height

h = @(l,a) l * sind(a);
fprintf("Height = %1.2f m\n", h(rampLength,angle))

%% Energuy Calculations and V final
Etot = @(v,height, m) (0.5 .* v^2 + 9.81 .* height) .* m;

Etot1 = Etot(v0,h(rampLength,angle),mass);

vf = @(E, m) sqrt(2 .* E ./m);

vf1 = vf(Etot1,mass);

fprintf("He is going %1.2f m/s at the bottom of the ramp\n", vf1)

%% Multiple angles, assuming ramp length and v0 are constant

angles = 15:5:45;
heights = h(rampLength,angles);
Etotals = Etot(v0,heights,mass);
vfs = vf(Etotals,mass);


yyaxis left;
plot(angles,heights,"b");
xlabel("Angle (DEG)");
ylabel("Height (m)")

yyaxis right;
plot(angles,vfs,"rp");
ylabel("Velocity at the bottom of the ramp (m/s)")


title("Angle vs Height of ramp");
grid on;





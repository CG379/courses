% Q5

% Some code may already be provided below
% DO NOT clear, close or clc inside this script
% Apply good programming practices
%
% Name : Campbell Gregor
% ID   : 33110018
% Date Modified : 12/10/22

fprintf('\n Q5 \n\n')
%%
%Add your code here
fanD = 70.5; % m
h = 80; % m
g = 9.81;

%% QA
mBlade = 1500; % kg
fSpeed = 120; % m/s
rFan = fanD /2; % m

F = mBlade * (fSpeed)^2 / rFan; % N


%% QB

housingD = 1; % m
housingR = housingD/2;
housingM = 500; %kg
lBlade = rFan - housingR; % m 

iThinRod = (1/12) * mBlade * lBlade^2;
iBlade = iThinRod + mBlade * (lBlade/2 + housingR)^2;
iHousing = housingM * housingR^2 /2;

iFan = iHousing + 3 * iBlade; % kg m^2



%% QC
fc = 0.001; 
totalMass = 3*mBlade + housingM; % kg
frictionF = totalMass * g * fc; % N


%% QD
fRad = 0.2; % m
Tf = frictionF * fRad; % N m
deceleration = Tf / iFan; % rad/s^2


%% QE
velTip = 30; % m/s
% u = v - at --> -u/a = t
stopTime = (velTip/rFan)/deceleration; % secs

stopTime = ((stopTime/60)/60)/24; % days

%% QF
energy = (1/2)*iFan*(velTip/rFan)^2; % J

%% Print results

fprintf("QA Force: %.3f N\n",F);

fprintf("QB Moment of Inertia: %.3f kg m^2\n",iFan);

fprintf("QC Friction Force: %.3f N\n",frictionF);

fprintf("QD Rotational deceleration: %.3f rad/s^2\n",F);

fprintf("QE Days till it stops: %.3f Days \n",stopTime);

fprintf("QF Energy Dissapated: %.3f J \n",energy);





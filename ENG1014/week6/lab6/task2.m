% Campbell Gregor
% Last modified: 30/8/22
% 33110018

clc; clear all; close all;

%% Gather inputs
mass = input("Input mass: ");
radius = input("Input radius: ");

shape = input("Select shape: 1) Sphere, 2) Hemisphere, 3) Thin circular disk, " + ...
    "or 4) Thin ring: ");

%% Moments of inertia depending on shape

    I_xx  = 0;
    I_yy = 0;
    I_zz = 0;
    I_zz2 = 0;

if shape == 1
    I_xx = 2 * radius ^ 2 * mass /5;
    I_yy = I_xx;
    I_zz = I_xx;

elseif shape == 2 
    I_xx  = 0.259 * mass * radius^ 2;
    I_yy = I_xx;
    I_zz = 2 * radius ^ 2 * mass /5;

elseif shape == 3
    I_xx  = mass * radius ^2 /4;
    I_yy = I_xx;
    I_zz = mass * radius ^2 /2;
    I_zz2 = 3 * mass * radius ^2 /2;
elseif shape == 4
    I_xx  = mass * radius ^2 /2;
    I_yy = I_xx;
    I_zz = mass * radius ^2;

else
    fprintf("Unknown option")
end


%% Printing to user
if I_zz2 ~=0
    fprintf("I_xx = %g  I_yy = %g  I_zz = %g  I_z'z' = %g", I_xx ,I_yy ,I_zz ,I_zz2)
elseif I_zz2 == 0 && I_xx ~= 0
    fprintf("I_xx = %g  I_yy = %g  I_zz = %g", I_xx ,I_yy ,I_zz)
end

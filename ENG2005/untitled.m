clear; % clear variables
clc; % clear command window
close all

%% Test
omega = -79 / 0.9;
test = omega * 0.3;
vba = 38 - 79 + test

omegadot = 11/0.9;

test2 = 0.3 * omega^2; % j

test3 = omegadot * 0.3 % i

test4 = omega * 2 * vba; % j

at = -9 - test3;
an = (76^2/0.9)- test2 - test4


a = sqrt(at^2 + (an)^2)

%% Q2

clear; % clear variables
clc; % clear command window
close all

omegar = -6.2 * -86;
romega2 = 3.9^2 * 6.2;

correlolus = 2 * - 3.9 * 3.7;

at = romega2 - 84;
an = omegar + correlolus;

a = sqrt(at^2 + an^2)



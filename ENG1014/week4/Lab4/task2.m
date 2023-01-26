% Campbell Gregor
% Last modified: 17/8/22
% 33110018
% Task 2
clc; clear all; close all;
%% Importing Data and Functions
pendulum = importdata("Period_of_Pendulum_data.xlsx");

cols = pendulum.textdata(1,:);
cols = string(cols);
cols(4)="Error%";
id = pendulum.data(:,1);
mass = pendulum.data(:,2);
length = pendulum.data(:,3);
period = pendulum.data(:,4);

periodRange = @(length,gravity)  sqrt(length ./ gravity).*(2* pi);

error = @(exp, thero) ((exp - thero)./thero) * 100;

test = periodRange(length,9.81);
%% Plots
subplot(2,1,1);
plot(mass,period,"bv-")
thero = periodRange(length,9.81);
xlabel("Mass (kg)");
ylabel("Period (s)");


subplot(2,1,2);
plot(length,thero,"gs-")
xlabel("Length (m)");
ylabel("Period (s)");


%% Printing data
errorMargin = error(period,thero);

fprintf("Experiment_ID \t Period_EXP(s) \t Period_TH(s) \t Error%%\n");

for i = 1:13
fprintf("\t %1.0f  \t %1.2f \t  \t %1.2f  \t \t %1.2f \n", id(i), period(i), thero(i), errorMargin(i));
end

g10 = periodRange(length(9),10);

error9 = error(thero(9),g10);

fprintf("The margin of error using g=10m/s^2 for id=9 is %1.2f%%\n",error9);



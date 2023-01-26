% Campbell Gregor
% Last modified: 14/9/22
% 33110018

clc; clear all; close all;

bugData = importdata("cockcroach_population.xlsx");

MSE = @(yexp,ymodel) (sum(yexp - ymodel).^2) / length(yexp);



day = bugData.data(:,1);
population = bugData.data(:,2);

hold on;
plot(day,population,"k");
xlabel("Time (Days)");
ylabel("Polulation");
title("Cockcroach Population Growth");

%% Polynomial model
p = polyfit(day,population,2);

model = polyval(p,day);

plot(day,model,"b")

polyMSE = MSE(population, model);

fprintf("Polynomial Model is: y = %.2f * x^2 + %.2f * x + %.2f \n", p);

%% Exp model

[a,a0,r] = linreg(day,log(population));

expModel = exp(a0) .* exp(day .* a);

plot(day,expModel,"r");
legend("Experimental", "Poly Model", "Exp Model");

expMSE = MSE(population, expModel);


allMSE = [polyMSE,expMSE];

[min, index] = min(allMSE);

fprintf("Model number %d was the more accurate one.\n", index);




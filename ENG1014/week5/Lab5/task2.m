% Campbell Gregor
% Last modified: 21/8/22
% 33110018

clc; clear all; close all;

%% Initial Values from question
price = 1100000;
savings = price * 0.05;
income = 84000;
savingsRate = 0.31;
savingsGoal = price * 0.1;
incomeIncrease = 0.04;
houseIncrease = 0.10;
requiredDeposit = price * 0.1;

%% Set up a counter and vector to put values in to

years = 0;
v = [];
while savings < price * 0.1
    % Addition to savings
    savings = savings + income * 0.31;
    % House price and deposit increase
    price = price + price * 0.1;
    requiredDeposit = price * 0.1;
    % Income Increse
    income = income + income *0.04;
    % Put into vector and inciment year
    v = [v;2022 + years, price, requiredDeposit, savings, income];  
    years = years + 1;
end

%% Plot assuming house price and savings against year 

plot(v(:,1), v(:,2), "b", v(:,1), v(:,4), "r");
xlabel("Year");
ylabel("Price $");
title("House Prices and Deposit growth over time");
legend("House Price", "Savings Deposit");

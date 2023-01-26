% Campbell Gregor
% Last modified: 13/9/22
% 33110018

clc; clear all; close all;

DomiPath = importdata("dominoes.txt");
DomiColours = importdata("domino_colours.xlsx");

path1 = [DomiPath.data(:,1),DomiPath.data(:,2)];
path2 = [DomiPath.data(:,3),DomiPath.data(:,4)];
path3 = [DomiPath.data(:,5),DomiPath.data(:,6)];

DomiColours = DomiColours(2:end,:);



%% Part 1

green1 = DomiColours(:,1) == "g";
red1 = DomiColours(:,1) == "r";
blue1 = DomiColours(:,1) == "b";

green2 = DomiColours(:,2) == "g";
red2 = DomiColours(:,2) == "r";
blue2 = DomiColours(:,2) == "b";

green3 = DomiColours(:,3) == "g";
red3 = DomiColours(:,3) == "r";
blue3 = DomiColours(:,3) == "b";

hold on;
% Path 1
plot(path1(green1,1),path1(green1,2), "go")
plot(path1(red1,1),path1(red1,2), "ro")
plot(path1(blue1,1),path1(blue1,2), "bo")

% Path 2

plot(path2(green2,1),path2(green2,2), "go")
plot(path2(red2,1),path2(red2,2), "ro")
plot(path2(blue2,1),path2(blue2,2), "bo")



% Path 3

plot(path3(green3,1),path3(green3,2), "go")
plot(path3(red3,1),path3(red3,2), "ro")
plot(path3(blue3,1),path3(blue3,2), "bo")



xlabel("x Distance (m)")
ylabel("y Distance (m)")
title("Dominoe Positions");


%% Part 2

[a1,a01,r21] = linreg(log(path1(:,1)),log(path1(:,2)));

powerModel1 = exp(a01) .* (1:50) .^a1;
model1 = exp(a01) .* path1(:,1) .^a1;

[a2,a02,r22] = linreg(log(path2(:,1)),log(path2(:,2)));

powerModel2 = exp(a02) .* (1:50) .^a2;
model2 = exp(a02) .* path2(:,1) .^a2;

[a3,a03,r23] = linreg(log(path3(:,1)),log(path3(:,2)));

powerModel3 = exp(a03) .* (1:50) .^a3;
model3 = exp(a03) .* path3(:,1) .^a3;

fprintf("Path 1: y = %1.2f * x^ %1.2f\n", exp(a01), a1)
fprintf("Path 2: y = %1.2f * x^ %1.2f\n", exp(a02), a2)
fprintf("Path 3: y = %1.2f * x^ %1.2f\n", exp(a03), a3)


path1Line = plot((1:50), powerModel1,"r");
path2Line = plot((1:50), powerModel2, "b");
path3Line = plot((1:50), powerModel3,"k");

legend([path1Line,path2Line, path3Line],{'Path 1', 'Path 2', 'Path 3'}, "Location","northwest")

hold off;

%% Part 3
ballRad = 0.3;



count1r = sum( (abs(path1(:,2) - model1) <= ballRad) & red1) * 10;

count1g = sum( (abs(path1(:,2) - model1) <= ballRad) & green1) * 5;

count1b = sum( (abs(path1(:,2) - model1) <= ballRad) & blue1) * 2;

count1Tot =  count1r + count1g + count1b;



count2r = sum( (abs(path2(:,2) - model2) <= ballRad) & red2) * 10;

count2g = sum( (abs(path2(:,2) - model2) <= ballRad) & green2) * 5;

count2b = sum( (abs(path2(:,2) - model2) <= ballRad) & blue2) * 2;

count2Tot =  count2r + count2g + count2b;


count3r = sum( (abs(path3(:,2) - model3) <= ballRad) & red3) * 10;

count3g = sum( (abs(path3(:,2) - model3) <= ballRad) & green3) * 5;

count3b = sum( (abs(path3(:,2) - model3) <= ballRad) & blue3) * 2;

count3Tot =  count3r + count3g + count3b;


totalts = [count1Tot, count2Tot, count3Tot];


[max, winner] = max(totalts);


fprintf("The best-earning path is Path %d, with %d points earned.", winner, max);


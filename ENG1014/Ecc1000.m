
clc; close all;
%{
Tenders = [60,55,47,35,20,0];
PopChicken = [0,20,35,47,55,60];

plot(PopChicken,Tenders,"k-");
xlabel("No. of Popcorn Chicken");
ylabel("No. of Chicken Tenders");
title("PPF for Popcorn Chicken and Chicken Tenders");
grid on;
%}
%{
xP = 0:0.1:3;
xJ = 0:0.1:8;

hold on;
plot(xP,xP.*-1 + 3,"b-");
xlabel("No. of Lemons");
ylabel("No. of Olives");
title("PPF for Paul");
grid on;
trapz(xP,xP.*-1 + 3);
area(xP,xP.*-1 + 3,'FaceColor','b',"FaceAlpha",0.5);
%}
%{
hold on;
plot(xJ,xJ.*-(10/8) + 10,"b-");
xlabel("No. of Lemons");
ylabel("No. of Olives");
title("PPF for Jackie");
grid on;
area(xJ,xJ.*-(10/8) + 10,'FaceColor','b',"FaceAlpha",0.5);
%}



xc = 0:0.1:100;
xd = 0:0.1:75;
%{
hold on;
plot(xc,xc.*-(0.5) + 50,"b-");
xlabel("No. of Burgers");
ylabel("No. of Donuts");
title("PPF for Carl");
grid on;

area(xc,xc.*-(0.5) + 50,'FaceColor','b',"FaceAlpha",0.5);

hold on;
plot(xd,xd.*-(25/75) + 25,"b-");
xlabel("No. of Burgers");
ylabel("No. of Donuts");
title("PPF for David");
grid on;
plot(30,15,"d-");
area(xd,xd.*-(25/75) + 25,'FaceColor','b',"FaceAlpha",0.5);

%}





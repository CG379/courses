% Maths Assignment
clc; clear all; close all;

psi = 40;
theta = -70;

n0 = [1;0;0];
alpha = 50;
beta = 20;


rz = [cosd(psi), -sind(psi),0; sind(psi),cosd(psi),0; 0,0,1];

ry = [cosd(theta), 0,sind(theta);0,1,0;-sind(theta),0,cosd(theta)];

n = rz * ry * n0;



as = [sind(alpha) * cosd(beta);sind(alpha)*sind(beta); cosd(alpha)];


ar = as + 2*dot(-as, n)*n;
desiredOutput = [-0.2743; 0.1118; 0.9551];



c = [21;10;28];
temp = c.*c;
sum = sum(temp);
unit = sqrt(sum);
c = c./unit;

n10 = (sqrt(2).*(c+as))./(2 * sqrt(dot(c,as) + 1));


theta = asind(-n10(3))



%t = solve([(as(1) + 2*dot(-as, n)*n(1)) == c(1), (as(2) + 2*dot(-as, n)*n(2)) == c(2), (as(3) + 2*dot(-as, n)*n(3)) == c(3)] , [wierd4 theta])


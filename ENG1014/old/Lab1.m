% Campbell Gregor
% Last modified: 5/8
% 33110018

clc; clear all; close all;

% Task 2
figure(1);
x1 = 0:0.1:10;
x2 = 10:0.1:30;

% Displacement
theta1 = x1.^2 + 50;
theta2 = 20*x2 - 50;

subplot(3,1,1)
plot(x1,theta1, "r-" ,x2,theta2,"b-");
xlabel("t");
ylabel("Angular Displacement");
grid on;

% Velocity
w1 = 2 * x1;
w2 = x2 .* zeros(length(x2)) + 20;
subplot(3,1,2)
plot(x1,w1, "r-" ,x2,w2,"b-");
xlabel("t");
ylabel("Angular Velocity");
grid on;

% Acceleration
a1 = x1 .* zeros(length(x1)) + 2;
a2 = x2 .* zeros(length(x2));
subplot(3,1,3)
plot(x1,a1, "r-" ,x2,a2,"b-");
xlabel("t");
ylabel("Angular Acceleration");
grid on;


% Task 3
figure(2);
v = 0:25:100;
v1 = 0:10:100;
f1 = [0,21.1,144.6,245,458];
f2 = [0, 18.7, 130.7, 239.6, 423.8];
f3 = [0 ,26.4 ,120.6, 225.5, 449.6];

F1 =  (v1.^2.2085) .* 0.0189;
F2 = (v1.^2.007) .* 0.0426;
F3 = (v1.^2.2369) .* 0.0158;


% Tried with all on one graph but the overlap made it hard to interpret so
% decided to do subplots
subplot(3,1,1);
plot(v,f1,'d','color','r'); 
hold on;
plot(v1,F1,"r-..", 'LineWidth',2);
hold off;
subplot(3,1,2);
plot(v,f2,'d','color','b'); 
hold on;
plot(v1,F2,"b-..", 'LineWidth',2);
hold off;

subplot(3,1,3);
plot(v,f3,'d','color','g'); 
hold on;
plot(v1,F3,"g-..", 'LineWidth',2);
hold off;

% Task 4 

% Constant acceleration
% in km
lap = 1;
% convert to m
s = lap * 1000;
% in cm
tyreRadius = 48.26;
% convert to m
r = tyreRadius/100;

% starting velocity in km/h
startingVelocity = [0.6, 0.8, 0.2, 0.2; 
    0.2, 0.5, 0.5, 0.1; 
    0.1, 0.5, 1.1, 0.0;
    0.6, 0.9, 0.3, 0.6; 
    0.5, 0.7, 0.6, 1.0;];
% tam times in s
Times  = [15.531, 15.555, 15.569, 15.200;
    16.019,15.731, 15.734, 15.087;
    15.586, 15.815, 15.541, 15.131; 
    15.129, 15.253, 15.200, 15.927;
    15.191, 15.121, 15.421, 15.560;];

% find constant acceleration of each lap
% therefore use s = v0 * t + 0.5 * a * t^2

% Got wierd answers with the equation below
%A = (s - (startingVelocity .* Times)) .* (Times.^2).*2;
A = zeros(5,4);
for i = 1:5
    for j = 1:4
        A(i,j) = (s - startingVelocity(i,j) * Times(i,j)) * 2 /(Times(i,j))^2;
    end
end

% Average acceleration
AvgA = zeros(1,4);

for i = 1:4
    Avg = 0;
    for j = 1:5
        Avg = Avg + A(j,i);
    end
    AvgA(i) = Avg; 
end

% max acceleration value in the list
% 1 =Wark, 2 =Rico, 3 =Polyon, 4 =Benson
fastest = find(AvgA==max(AvgA));
% Benson was able to accelerate the fastest

% Final angular velocity
% wf = wi + a*t, convert tangential to radial w = v/r

final = startingVelocity + (A .* Times);

radialFinal = (final ./r).';

figure(3);

plot([1,2,3,4],radialFinal);
xlabel("lap");
ylabel("Final Radial Velocity");
grid on;
legend("Wark", "Rico","Polyon", "Benson", "location", "north");

% Task 5

% Equation used s/t - 0.5 * a * t = vi
g = -9.8;
s5 = -1;
angle = 30;
t5 = [1.1, 1.3, 1.33, 1.55, 1.6, 1.7];
names = ["Ivy", "John", "Ella", "Steve", "Callum", "Tyree"];

figure(4);

vi =(s5 - t5.*(0.5 * -9.8))./t5;
R = (vi.* sind(30)) .* t5;

plot(R,vi, "o-");
xlabel("Horizontal Displacement")
ylabel("Takeoff velocity")
text(R,vi,names)


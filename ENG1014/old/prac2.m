% Campbell Gregor
% Last modified: 4/8
% 33110018

clc; clear all; close all;

figure(1);
x = (0:0.1:10);
y1 = x.^2.*cos(x);
y2 = x.*sin(x);
subplot (2,1,1)
plot(x,y1,"b")
title("Subplot 1")
xlabel("x")
ylabel("y")
grid on
legend('y1', "location", "best");

subplot(2,1,2)
title("Subplot 2")
plot(x, y2, "g")
xlabel("x")
ylabel("y2")
grid on
legend('y2', "location", "best");

figure(2);

% plot(x, y1, "m-”, x,y2, “r–”)
y3 = exp(-0.5*x).*sin(5*x);
y4 = exp(-0.5*x);
hold on;
plot(x,y3,"m-");
title("2 plots in 1")
grid on;

plot(x,y4,"r--")
legend('y1', "y2", "location", "best");
xlabel("x")
ylabel("y")
hold off;
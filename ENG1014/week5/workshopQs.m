% Campbell Gregor
% Last modified: 10/8/22
% 33110018

clc; clear all; close all;
%% lat long
%{
locations = importdata("latlong.txt");

lats = locations.data(:,1);
longs = locations.data(:,2);

hold on;
for i = 1:length(lats)
    if (lats(i) > 0) & (longs(i) > 0)
        plot(longs(i),lats(i), "ro")
    elseif (lats(i) < 0) & (longs(i) > 0)
        plot(longs(i),lats(i), "bo")
    elseif (lats(i) < 0) & (longs(i) < 0)
        plot(longs(i),lats(i), "go")
    else
         plot(longs(i),lats(i), "ko")
    end
end
hold off;
xlabel("Longitude");
ylabel("Latitude");
title("Latitude vs Longitude");
legend("+long.+lat", "+long.-lat","-long.-lat","-long.+lat","location","northeast");
%}

%% Tension loader
tensions = importdata("tensions.txt");
tests = 1:1:100;


placement = tensions < 5 | tensions > 88;

hold on;
for i = 1:length(tests)
    if placement(i) == 1
        plot(tests(i),tensions(i),"kv");
    end
end


%% First Home
balance = @(P,r,n,t) P .* (1 + ((r/100)./n)).^(n.*t);
p = 1000;
r = 3.5;
n = 3;
fprintf("The balance after 5 years is $%.2f\n", balance(p,r,n,5));

b = 0;
year = 0;
while (b - p) < 1000
    year = year + 1;
    b = balance(p,r,n,year);
end

fprintf("it will take %d year(s) to earn more than +$1000 in interest, compounding 3 times a year\n", year);


year2 = 0;
b = 0;
while (b - p) < 1000
    year2 = year2 + 1;
    b = balance(p,365,n,year2);
end

fprintf("it will take %d year(s) to earn more than $1000 in interest, compounding everyday\n", year2);


%% 4 digit clock





% Q2

% Some code may already be provided below
% DO NOT clear, close or clc inside this script
% Apply good programming practices
%
% Name : Campbell Gregor
% ID   : 33110018
% Date Modified : 4/10/22

fprintf('\n Q2 \n\n')
%% 
%Add your code here


%Print results

% Part a
%You should have produced three figure windows by the end of this task.

second = zeros(1,length(year));
second = second';
% Formatting the dates
x = datetime(year,month,day,hour,mins,second,'InputFormat','yyyy-MM-dd HH:mm:ss');
t = datenum(x);

figure(1)
%Plotting for (a)
subplot(3,1,1);

plot(t,ararat(:,2),"b",'LineWidth',1);
title("Ararat Wind Speed vs Time");
datetick("x");
xlabel("Time");
ylabel("Wind Speed (m/s)");

subplot(3,1,2);
title("Boco Rock Wind Speed vs Time");
plot(t,boco(:,2),"b",'LineWidth',1);
datetick("x");
xlabel("Time");
ylabel("Wind Speed (m/s)");

subplot(3,1,3);
title("Silverton Speed vs Time");
plot(t,silverton(:,2),"b",'LineWidth',1);
datetick("x");
xlabel("Time");
ylabel("Wind Speed (m/s)");




%% Part b
% Isolate the wind data to get the max
Winds = [ararat(:,2),boco(:,2), silverton(:,2)];

counts = [0,0,0];
% Count each time the index is the max
for i = 1:length(ararat(:,2))
    [maxW, index] = max(Winds(i,:));
    counts(index) = counts(index) + 1;
end

figure(2)
%Plotting for (b)
pie(counts);
legend(["Ararat", "Boco Rock", "Silverton"]);
title("% Time with largest wind speed")

%% Part c
% There are 144 10min blocks in a day (24h * 60/10)

averageA = zeros(144,1);
averageB = averageA;
averageS = averageA;

% Isolate date time values to just the time of day values
dayTimes = timeofday(x);
dayTime = duration(0,0,0);

i = 0;
while i < 144
    i = i + 1;
    % Find index of all times that match, eg all 00:00:00 times
    timeIndex = dayTimes == dayTime;
    
    % Find the average speeds at that specific time
    averageA(i) = sum(Winds(timeIndex,1))/sum(timeIndex);
    averageB(i) = sum(Winds(timeIndex,2))/sum(timeIndex);
    averageS(i) = sum(Winds(timeIndex,3))/sum(timeIndex);

    % Incriment the time of day by 10 mins
    dayTime = dayTime + duration(0,10,0);
end


figure(3)
%Plotting for (c)
% Time interval needs to be same length as values (144)
timeInterval = linspace(duration(0,0,0),duration(23,50,0),144);
plot(timeInterval,averageA,timeInterval,averageB,timeInterval,averageS);
% Show as time on the x axis
datetick('x','HH:MM','keepticks');
xlabel("Time of Day");
ylabel("Average Wind Speed (m/s)");
legend("Ararat","Boco Rock", "Silverton", "Location","Best");
title("Average Wind speed throughout the day");










% Campbell Gregor
% Last modified: 24/8/22
% 33110018

clc; clear all; close all;


EMG = importdata("EMGdata.txt");
% isolating the data
time = EMG.data(:,1);
ch1 = EMG.data(:,2);
ch2 = EMG.data(:,3);
ch3 = EMG.data(:,4);
ch4 = EMG.data(:,5);

%% Part 1
% plotting the data
subplot(2,1,1);
hold on;
plot(time,ch1,"b",time,ch2,"r", time,ch3,"k", time,ch4, "g");
xlabel("Time (s)");
ylabel("Muscle Activity (mV)");
title("Muscle Activity over time")

% Finding the max of each channel
[max1, index1] = max(ch1);
[max2, index2] = max(ch2);
[max3, index3] = max(ch3);
[max4, index4] = max(ch4);

% Plot max values
plot(time(index1), max1, "b^", time(index2), max2, "r^", time(index3), max3, "k^", ...
time(index4), max4, "g^");
legend("Channel 1", "Channel 2", "Channel 3", "Channel 4", "Max Ch 1", "Max Ch 2","Max Ch3" , ...
    "Max Ch4", "location", "best");
hold off;

%% Part 2

% Altering the Values

ch1((ch1 > 0.65) | (ch1 < 0.12)) = ch1((ch1 > 0.65) | (ch1 < 0.12)) .* (1-0.13);
ch2((ch2 > 0.65) | (ch2 < 0.12)) = ch2((ch2 > 0.65) | (ch2 < 0.12)) .* (1-0.13);
ch3((ch3 > 0.65) | (ch3 < 0.12)) = ch3((ch3 > 0.65) | (ch3 < 0.12)) .* (1-0.13);
ch4((ch4 > 0.65) | (ch4 < 0.12)) = ch4((ch4 > 0.65) | (ch4 < 0.12)) .* (1-0.13);

channels = [ch1,ch2,ch3,ch4];

% New Maxes
[max1, index1] = max(ch1);
[max2, index2] = max(ch2);
[max3, index3] = max(ch3);
[max4, index4] = max(ch4);
maxes = [max1,max2,max3,max4];
indexTime = [index1,index2,index3,index4];
% Print values
fprintf("The max voltage for Channel 1 is %.2f mV, this ocurrs at time %.2f s\n", max1, time(index1));
fprintf("The max voltage for Channel 2 is %.2f mV, this ocurrs at time %.2f s\n", max2, time(index2));
fprintf("The max voltage for Channel 3 is %.2f mV, this ocurrs at time %.2f s\n", max3, time(index3));
fprintf("The max voltage for Channel 4 is %.2f mV, this ocurrs at time %.2f s\n", max4, time(index4));

%% Part 3

%{
In the second subplot , plot the voltage against time of the channel that has the highest voltage after being corrected.
Plot this as a black line highlighting the maximum point as a circle coloured with the colour hex code #CF202A and a
marker size of 10. Add appropriate x & y-axis labels and include the requested channel number as part of the subplot
title.
%}
% Finding the Correct channel
[maxValue, maxIndex] = max(maxes);
maxTime = time(indexTime(maxIndex));
plotChannel = channels(:,maxIndex);


% Converting hex to rgb code
hex = '#CF202A';

r = double(hex2dec(hex(2:3)))/255;
g = double(hex2dec(hex(4:5)))/255;
b = double(hex2dec(hex(6:7)))/255;

colour = [r,g,b];


% Second subplot
subplot(2,1,2);
hold on;
plot(time,plotChannel,'k');
plot(maxTime,maxValue,'o','MarkerSize',10, Color=colour);
hold off;

xlabel("Time (s)");
ylabel("Muscle Activity (mV)");
title("Muscle Activity over time for max Channel")






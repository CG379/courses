clear all;clc;close all;
%Written by AER
%Edited 14/3/22

jumping_data = importdata("long_jump_records.txt");
rank = jumping_data.data(1,:);
distance = jumping_data.data(2,:);
windspeed = jumping_data.data(3,:);

[max_wind,wind_index]=max(windspeed)
fprintf("distance for max windspeed = %f\n",distance(wind_index))
%The "numbers.txt" file contains 10,000 random integers
%This file should import this data, and then count how many numbers are
%divisible by 3, and how many are divisible by 7
%It should print both of these counts, and store the list of each set of
%numbers as variables
%The solution should give 3291 numbers that are divisible by 3, and 1375
%numbers that are divisible by 7

clear all; close all; clc;

%all numbers
all_nums = importdata('numbers.txt');

%lucky number occurence
counter_3=0 ;
counter_7=0 ;


for i=1:length(all_nums)
    
    if rem(all_nums(i),3)==0 %if divisible by 3
        num_3div(counter_3)=all_nums(i) ;%save the numbers that are divisible into a list
        counter_3=counter_3+1 ; %increase the count so we know how many are divisible
    
    elseif rem(all_nums(i),7)==0 %as above, but for divisible by 7
        num_7div(counter_7)=all_nums(i) ;
        counter_7=counter_7+1 ;   
    end
end
 

%print statement
fprintf('Numbers ending with 3 appear %d times and numbers ending in 7 appears %d times.\n',...
    counter_3, counter_7)


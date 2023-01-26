% Campbell Gregor
% Last modified: 24/8/22
% 33110018

clc; clear all; close all;


randomNums = importdata("numbers.txt");

% What is divisible by 4 that ends in 5?
fiveFour = sum((mod(randomNums,10) == 5)&(rem(randomNums,4) == 0));
% Number of things that end in 2. Anythjing that ends in 2 is divisible by
% 2 so no need to do anything else.
twos = sum((mod(randomNums,10) == 2));
% Max and count of divisible by 4 and ends in 5
max5_4 = max(randomNums((mod(randomNums,10) == 5)&(rem(randomNums,4) == 0)));
count4_5 = sum(randomNums((mod(randomNums,10) == 5)&(rem(randomNums,4) == 0)) == max5_4);

% Max num ends in 2
max2 = max(randomNums(mod(randomNums,10) == 2));

% Print values
fprintf("There are %d numbers that are divisible by 4 and end in 5\n", fiveFour);
fprintf("There are %d numbers that end in 2 and are divisible by 2\n", twos);
fprintf("The maximum number that ends in 5 and divisible by 4 is %d, it ocurrs %d times\n", ...
    ~isempty(max5_4),count4_5);





% Q1

% Some code may already be provided below
% DO NOT clear, close or clc inside this script
% Apply good programming practices
%
% Name : Campbell Gregor
% ID   : 33110018
% Date Modified : 27/9/22

fprintf('\n Q1 \n\n')
%%
%Add your code here

% yyyyMMddHHmm

ararat = importdata("ararat.txt");
boco = importdata("boco_rock.txt");
silverton = importdata("silverton.txt");


% Isolate columns
year = floor(ararat(:,1)/10^8);
day = rem(floor(ararat(:,1)/10^6),100);
month = rem(floor(ararat(:,1)/10^4),100);
hour = rem(floor(ararat(:,1)/10^2),100);
mins = rem(floor(ararat(:,1)),100);

% Final Array
WindData = [year, month, day, hour, mins, ararat(:,2),boco(:,2), silverton(:,2)];

%Print results
results = WindData(1:4,:);
fprintf("Year\tMonth\tDay\tHour\tMin\tArarat\tBoco_Rock\tSilverton\n")
fprintf("%d %7d %5d %8d %6d %10.2f %8.2f %15.2f\n", results(1,:),results(2,:), ...
    results(3,:), results(4,:))

%Create output file

araratValues = ararat(:,2) <=0;
bocoValues = boco(:,2) <=0;
silverValues = silverton(:,2) <=0;

ararat(araratValues,2) = 0;
boco(bocoValues,2) = 0;
silverton(silverValues,2) = 0;


% Find moving average either side
pattern=[1,1,1,0,1,1,1]./6;

mAvgA = conv(ararat(:,2),pattern,"same");
mAvgB = conv(boco(:,2),pattern,"same");
mAvgS = conv(silverton(:,2),pattern,"same");

% Invalid points index
invalidA = ((ararat(:,2) ./ mAvgA) < 0.3) | ((ararat(:,2) ./ mAvgA) > 1.7);
invalidB = ((boco(:,2) ./ mAvgB) < 0.3) | ((boco(:,2) ./ mAvgB) > 1.7);
invalidS = ((silverton(:,2) ./ mAvgS) < 0.3) | ((silverton(:,2) ./ mAvgS) > 1.7);

% Replacing invalid points
ararat(invalidA,2) = mAvgA(invalidA);
boco(invalidB,2) = mAvgB(invalidB);
silverton(invalidS,2) = mAvgS(invalidS);

% Finding Eddited Points
AEdits = araratValues | invalidA;
BEdits = bocoValues | invalidB;
SEdits = silverValues | invalidS;

% Final Array
WindData = [year, month, day, hour, mins, ararat(:,2), AEdits,boco(:,2), BEdits, silverton(:,2), SEdits];


% Create Log file
file = fopen('cleaned_data.txt','w');

% Year, Month, Day, Hour, Min, Ararat, Ararat Edits, Boco, Boco Edits,
% Silverton, Silverton Edits
fprintf(file,"Year,Month,Day,Hour,Min,Ararat,Ararat Edits,Boco,Boco Edits," + ...
    "Silverton,Silverton Edits\n");

fprintf(file,"%d,%d,%d,%d,%d,%f,%d,%f,%d,%f,%d\n",WindData');

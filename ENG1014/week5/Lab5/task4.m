% Campbell Gregor
% Last modified: 24/8/22
% 33110018

clc; clear all; close all;

%% Values fromn question
nmax = 50;

bRange = 5:1:30;
aRange = 10:1:25;

pValues = []; %[n,alpha,beta,p];


%% Create the matrix
for a = aRange
    for b = bRange
        p = 0;
        for n = 1:nmax
            p = p + abs(sin(b) + abs(cos(a)./n.^2));
        end
        pValues = [pValues; n,a,b,p./100];
    end
end
%% Finding the min and printing it
[minProb, minIndex] = min(pValues(:,4));

fprintf("Lowest Probability is %f with alpha = %d and beta = %d\n", minProb, ...
    pValues(minIndex,2), pValues(minIndex,3));

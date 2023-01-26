% Q4

% Some code may already be provided below
% DO NOT clear, close or clc inside this script
% Apply good programming practices
%
% Name : Campbell Gregor
% ID   : 33001118
% Date Modified : 10/10/22

fprintf('\n Q4 \n\n')
%%
%Add your code here
performance = importdata("performance_measures.txt");
WindSpeed = performance.data(:,1);
Cp = performance.data(:,2);

% Fitting data to polynomial

% Splitting it up
W1 = WindSpeed(1:13);
W2 = WindSpeed(15:end);
Cp1 = Cp(1:13);
Cp2 = Cp(15:end);

% Fitting for first half
i = 0;
r21 = 0;
while r21 <= 0.996
i = i + 1;
P1= polyfit(W1,Cp1,i);
model1 = polyval(P1,W1);

% r^2 value
St1 = sum((Cp1-mean(Cp1)).^2);
Sr1 = sum((Cp1 - model1).^2);
r21 = (St1 - Sr1)/St1;
end

% Fitting for second half
r22 = 0;
i = 0;
while r22<= 0.996
i = i + 1;
P2= polyfit(W2,Cp2,i);
model2 = polyval(P2,W2);

% r^2 value
St2 = sum((Cp2-mean(Cp2)).^2);
Sr2 = sum((Cp2 - model2).^2);
r22 = (St2 - Sr2)/St2;
end

x1 = 2:0.1:W1(end);
x2 = W2(1):0.1:(W2(end)+1);
model1 = polyval(P1,x1);
model2 = polyval(P2,x2);

% Wc wind to slow to produce energy (cut-in)
% Wf wind above threshold operates at maximum
% Wcutout wind too fast to produce energy

%% Part b
modelA = @(x) P1(1) .*x.^5 +  P1(2) .*x.^4 +  P1(3) .*x.^3 + P1(4).* x .^2 +P1(5).*x + P1(6);
modelB = @(x)  P2(1) .*x.^2 +  P2(2) .*x +  P2(3);

% wf cutoff at the max value of cp
WfModel = @(x) modelB(x)  - max(Cp);
% Other values at cp = 0
WciModel = @(x) modelA(x);
WcoModel = @(x) modelB(x);

% ModSecant
wf = modsecant(WfModel,15,0.1,10^(-2));
wci = modsecant(WciModel, 5,0.1,10^(-2));
wco = modsecant(WcoModel, 25,0.1,10^(-2));

%Print results
fprintf("\tWf\tWc\tWcutout\n");
fprintf("%10.3f %8.3f %8.3f\n",wf,wci,wco);

%You should have produced one figure window by the end of this task.
figure(4)
hold on;
plot(WindSpeed,Cp,"rs", x1,model1,"b--", x2,model2,"g--")
plot(wco,modelB(wco),"b*");
plot(wf,modelB(wf),"b*");
plot(wci,modelA(wci),"b*");
ylabel("Cp");
xlabel("Wind speed (m/s)");
title("Cp at different wind Speeds");
hold off;






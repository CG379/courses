% Q3

% Some code may already be provided below
% DO NOT clear, close or clc inside this script
% Apply good programming practices
%
% Name : Campbell Gregor
% ID   : 33110018
% Date Modified : 11/10/22

fprintf('\n Q3 \n\n')
%%
%Add your code here

% Wh = W0 (h/h0)^a

h0 = 100;



avgWindData = importdata("avg_wind_data.txt");
height = avgWindData.data(:,1);
avgArarat = avgWindData.data(:,2);
avgBoco = avgWindData.data(:,4);
avgSilverton = avgWindData.data(:,3);



%% Finding Alpha
%Print results
xnew = log(height./h0);
ynew = log(avgArarat);


[aA,a0A,r2A] = linreg(xnew,ynew);

ynew = log(avgBoco);

[aB,a0B,r2B] = linreg(xnew,ynew);

ynew = log(avgSilverton);

[aS,a0S,r2S] = linreg(xnew,ynew);



fprintf("\tArarat\tBoco Rock\tSilverton\n");
fprintf("r2: %11.4f, %9.4f, %15.4f\n",r2A,r2B,r2S);
fprintf("alpha: %7.3f, %9.3f %15.3f\n\n",aA,aB,aS);
fprintf("Ararat Terrain: Elements separated by large distances\nBoco Rock Terrain: " + ...
    "Larger elements uniformly distributed\nSilverton Terrain: Landscape with moderate occurrences\n")

%% Plotting
figure(6);
hold on;
A = plot(height,avgArarat,"bo",'MarkerSize',5);
A1 = plot(height,exp(a0A).*(height./h0).^aA, "b");
B = plot(height,avgBoco,"r*",'MarkerSize',9);
B1 = plot(height,exp(a0B).*(height./h0).^aB, "g--");
C = plot(height,avgSilverton,"m+",'MarkerSize',8);
C1 = plot(height,exp(a0S).*(height./h0).^aS, "m--");

xlabel("Height (m)");
ylabel("Average Wind Speed (m/s)");
title("Average Wind speed at different height");
legend([A,B,C],"Ararat","Boco Rock", "Silverton",'Location','northwest');
hold off;



%% Updated model
model = @(alpha,W0) W0 .* (100/80) .^alpha ;

%You should have updated one figure window by the end of this task.
figure(1)

subplot(3,1,1);
hold on;

plot(t,model(aA,ararat(:,2)),"r--","LineWidth",0.5);


subplot(3,1,2);
hold on;
plot(t,model(aB,boco(:,2)),"r--","LineWidth",0.5);


subplot(3,1,3);
hold on;
plot(t,model(aS,silverton(:,2)),"r--","LineWidth",0.5);




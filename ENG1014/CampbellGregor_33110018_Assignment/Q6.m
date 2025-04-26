% Q6

% Some code may already be provided below
% DO NOT clear, close or clc inside this script
% Apply good programming practices
%
% Name : Campbell Gregor
% ID   : 33110018
% Date Modified : 13/10/2022

fprintf('\n Q6 \n\n')
%%
%Add your code here
april2020 = x.Month == 4 & x.Year == 2020;
aprilArarat = ararat(april2020,2);
powerApril = PowerFunc(aprilArarat,wci,wf,wco,modelA,modelB);
power = PowerFunc(ararat(:,2),wci,wf,wco,modelA,modelB);

% https://edstem.org/au/courses/9293/discussion/1063143 plot power fprintf

% energy
times2020 = (t(april2020)-t(1)) * (24 * 60 * 60);
E = comp_trap_vector(times2020,powerApril);


%Print results
fprintf("The amount of energy in April is %.3f J\n",E);

%You should have produced one figure window by the end of this task.
figure(5);
plot(x,power,"b");
xlabel("Date");
ylabel("Power Output (W)");
title("Ararat Power Output 2020");

fprintf("The most power generated is on 18 Jan 2021, Followed by June 19 2020\n");


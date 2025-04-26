% Campbell Gregor
% Last modified: 14/9/22
% 33110018

clc; clear all; close all;

x = 1:1:10;
yexp = [5, 8, 13, 22, 37, 60, 99, 164, 270, 445];
ypow = [2, 6, 10, 16, 22, 29, 37, 45, 54, 63];
ysat = [13, 21, 27, 32, 36, 38, 41, 43, 44, 46];

%% Exp 
hold on;
x_inexp = x;
y_inexp = log(yexp);

[a,a0,r2] = linreg(x_inexp,y_inexp);

alpha_exp = exp(a0);
beta_exp = a;

exp_model = alpha_exp .* exp(x.*beta_exp);
lin_exp = a.* x + a0; 

plot(x,exp_model,"k", x, lin_exp,"r");

%% pow
x_inpow = log(x);
y_inpow = log(ypow);

[a,a0,r2] = linreg(x_inpow,y_inpow);

alpha_pow = exp(a0);
beta_pow = a;

pow_model = alpha_pow .* x.^beta_pow;

lin_pow = a.* x + a0; 

plot(x,pow_model,"k", x, lin_pow,"r");


%% Sat

x_insat = 1./x;
y_insat = 1./ysat;

[a,a0,r2] = linreg(x_insat,y_insat);

alpha_sat = 1/a0;
beta_sat = a/a0;

sat_model = (alpha_sat .* x) ./(beta_sat + x);

lin_sat = a.* x + a0; 

plot(x,sat_model,"k", x, lin_sat,"r");
xlabel("X-axis")

yyaxis left;
ylabel("Y-axis")

yyaxis right;
ylabel("linearised Y-axis")








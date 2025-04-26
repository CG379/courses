
clc; clear all; close all;

f = @(x) sind(x) + sind(2.*x) + exp(0.01 .* x) -1.5;
x = 0:0.1:70;


y = @(x) x.^2 .* sind(4.*x);

interval = 5:0.1:30;
j = [];
k = 1;
for i = 3:100
    if (rem(i,2) ~= 0)
        area = comp_simp13(y,5,30,i);
        Int(i) = area;
        j(k) = i;
        k = k + 1;
    end
end

valid = Int ~= 0;

validInt = Int(valid);

plot(j,validInt);

Q3 = importdata("curvefit.txt");

x = Q3(1,:);
y = Q3(2,:);


[a,a0,r2]=linreg(x,y);
modelLin = @(x) a.*x + a0;

plot(x,y,x,modelLin(x))
test = modelLin(9.5);

xnew = x;
ynew = log(y);

[ae,a0e,r2e]=linreg(xnew,ynew);
expModel = @(x) exp(a0e).* exp(ae.*x);

test = expModel(9.5);
figure(1);
plot(x,y,x,modelLin(x),x,expModel(x))



dy = @(x,y) ((0.05.*(y - x)).^2)./exp((0.05.*(y - x).^2));

span = [0,120];

[t,y] = midpoint(dy,span,0,10);
figure(2)
plot(t,y)

[t,y] = euler(dy,span,0,2);
figure(3);
plot(t,y)



% Campbell Gregor
% Last modified: 5/10/22
% 33110018

clc; clear all; close all;

H = 25;

L = @(z) 10.*(z./(2+z)).* exp(-2 .* z ./ H);

Area = integral(L,0,H);

z = 0:0.1:H;

plot(z,L(z));
xlabel("z");
ylabel("L(z)")
title("Applied Load per Unit Length")


error = @(Ic,Ii) 2.*(abs(Ic - Ii)./(Ic + Ii)) .* 100;

%% Finding Trap rule segments
for i = 1:10000
    I1 = comp_trap(L,0,H,i);
    e = error(I1,Area);
    if e <= 0.01
        break
    end
end



% Segments for simp 1/3
for n = 3:2:10000
    I2 = comp_simp13(L,0,H,n);
    e = error(I2,Area);
    if e <= 0.01
        break
    end
end


fprintf("Integral: %.3f\n", Area);
fprintf("Min Segments Trap: %d\n",i);
fprintf("Min Segments Simp 1/3: %d\n",n);







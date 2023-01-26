% Campbell Gregor
% Last modified: 14/9/22
% 33110018

clc; clear all; close all;

tensileData = importdata("TensileData.xlsx");

strain = tensileData.data(:,1);
stress = tensileData.data(:,2);

% Plotting
hold on;
plot(strain,stress,"k");
xlabel("Strain (mm/mm)");
ylabel("Stress (MPa)");
title("Stress-Strain Curve");

% r^2 values
for i = length(stress):-1:1
    [a,a0,r2] = linreg(strain(1:i),stress(1:i));
    if r2 >= 0.99980
        break
    end
end

% Finding the right model
model = a .* strain(1:(i + 50)) + a0;

plot(strain(1:i + 50), model, "b--")



fprintf("Model of the tensile region: stress(MPa) = %5.1f * strain(%%) + %1.2f, where r^2 = %1.6f.\n", a,a0,r2)

% Yield strength should be where the loop ended
fprintf("The yield strength is %.1f MPa at %.6f %% strain.\n", stress(i), strain(i));
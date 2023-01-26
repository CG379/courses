function [P] = PowerFunc(W,Wci,Wf,Wco,f1,f2)
% 
% Power = PowerFunc(W,)
% Written by: Campbell Gregor, 33110018
% 
% Last edited: 13/10/22
% Calculate the Power with the equation P = 0.5 * Cp * rho * A * W^3
% Inputs: Wind speeds m/s, Cutin speed m/s, furling speed m/s, coutout speed m/s, peicewise
% one, peicewise 2
% Outputs: Power W
%

r = 70.5/2;
rho = 1.225;
A = pi * r^2;
constant = (1/2) * rho* A;

P = zeros(length(W),1);
%P = P';

for i = 1:length(W)
    speed = W(i);
    % Before cut in speed
    if speed < Wci
        P(i) = 0;
    % First half of fun
    elseif speed < Wf && speed > Wci
            P(i) = f1(speed)* constant * speed^3;
    % Second half of fun
    elseif speed > Wf && speed < Wco
            P(i) = f2(speed)* constant * speed^3;
    % Over cutout speed
    else
        P(i) = 0;
    end
end




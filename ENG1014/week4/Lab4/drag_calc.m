function Cd = drag_calc(Fd, rho, V, S)
% Cd = drag_calc(FD, rho, v, S)
% Written by: Campbell Gregor, 33110018
% 
% Last edited: 18/8/22
% Calculates the drag co-efficient according to this equation: Cd = (2FD)/(rho*v^2*S)
%
% Inputs: rho (kgm−3) air density, v (ms^−1) air velocity, Fd(N) is the drag force,
% S(m2) is the reference area.
% 
% Outputs: CD drag coeficient
Cd = (2* Fd)./(rho .* (V).^2 .* S);

end
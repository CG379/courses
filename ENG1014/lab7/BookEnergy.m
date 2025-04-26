function Energies = BookEnergy(Mass,Height)
% energies of books = BookEnergy(BookMass, BooKHeight)
% Written by: Campbell Gregor, 33110018
% 
% Last edited: 6/9/22
% Takes the starting height and mass of a book and calculateds its initial
% potential energy, kinetic energy halvway down and final velocity
% Gravity is assumed 9.81 m/s^2
% Inputs: Mass (kg) and Height (m)
% Outputs: [initial potential energy (J), kinetic energy half way down (J),
% final velocity (m/s)]
PE = Mass .* Height .* 9.81;
HalfEK = PE - Mass .* (Height ./ 2) .* 9.81;
Vf = sqrt(PE .* 2 ./ Mass);

Energies = [PE,HalfEK, Vf];

end


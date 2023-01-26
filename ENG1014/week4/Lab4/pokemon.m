function [volume, surfaceArea] = pokemon(a,b)
% [volume, surfaceArea] = pokemon(a,b)
% Written by: Campbell Gregor, 33110018
% Last edited:17/8/22
% 
% Outputs the surface area and volume of 3 joinded hexagonal prisms and 3 joined 3D parallelograms
% That are joined together, given a (the width of one hxagon/parallelogram
% side) and b (the legth of the shapes)
%
% Inputs: width a and length b
% Outputs: the volume and surface area 

% Cross section
cs = 3 * (a^2) * ((3*sqrt(3)/2)+1);
% Volume
volume = cs * b;
% Surface Area
surfaceArea = 25 * a * b + 2 * cs;

end

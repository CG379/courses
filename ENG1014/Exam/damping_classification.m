function [damping] = damping_classification(k,m,dA)
% damping] = damping_classification(k,m,dA)
% Written by: Campbell Gregor, 33110018
% 

constant = sqrt(4.*k.*m);

if dA == 0
    error('Undampended system')
elseif dA == constant
 damping = 0;
elseif dA > constant
    damping = 1;
elseif dA < constant
    damping = -1;
else
    error('Unrealistic values')
end
end


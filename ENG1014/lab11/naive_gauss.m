function x = naive_gauss(A,b)
% x = naive_gauss(A,b)
% uses naive Gaussian elimination to solve matrix equation
%
% INPUTS:
%  - A = square matrix of coefficients
%  - b = column vector of solutions
% OUTPUTS:
%  - x = column vector of unknowns

% Input Validation
[m,n] = size(A);
if m~=n
    error('Matrix A must be square')
end

%preallocating x
x = zeros(n,1);

%Augmented matrix
Aug = [A b];

%% forward elimination
for c = 1:n-1
    for r = c+1:n
        a_rc = Aug(r,c);
        a_cc = Aug(c,c);
        Aug(r,c:n+1) = Aug(r,c:n+1)*a_cc - Aug(c,c:n+1)*a_rc;
    end
end

%% back substitution
x(n) = Aug(n,n+1)/Aug(n,n);
for r = n-1:-1:1
    x(r) = (Aug(r,n+1) - Aug(r,r+1:n)*x(r+1:n))/Aug(r,r);
end

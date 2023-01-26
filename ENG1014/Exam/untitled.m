% Campbell Gregor
% Last modified: 10/11/22
% 33110018

clc; clear all; close all;

f = @(x) x.^3 * cos(x./10) + 6 * sin(x);

test = falseProp(f,40,10,0.001);

x = [1,2;3,2;12,4];
test = min(x,[ ], 2);

x =[1.1, 0.8,0.4,0.1,-0.2,-0.8];
y = [0.9,0.6,0.7,0.5,0.3,0.1];

[a,b,r] = linreg(x,y);

A = [1,2,-1;3,-1,2;2,0,1];
ans1 = [-7;9;9];

test1  = gauss_jordan(A,ans1);

y = @(x) cos(exp(x.^2 + 3.*x))./(2.*x + 3);

data = importdata("master_matrix.txt");

data34_9 = sum(rem(data(34,:),9) == 0);

newMat = data([3, 14, 17, 23,39], [4, 15, 17, 42,48]);
average = sum(sum(newMat))/25;

count = 0;
for i = 2:length(data)
    for j = 1:length(data)
        if data(i-1,j) == data(i,j)
            count = count + 1;
        end
    end
end


a = @(v) (550-0.3.*v-5.*v.^2)./75;


v1 = comp_simp13(a,0,1,9);

distance = 0;
i = 1;

t = 0:99;
while i < 100
    v(i) = comp_simp13(a,0,i,9);
    i = i + 1;
end
i = 1;
while distance < 100
    i = i + 1;
    if (length(v(1:i)) > 3) && (rem(length(v(1:i)),2) ~= 0)
        distance = comp_simp13_vector(t(1:i),v(1:i));
    end
    
end










accData = importdata("wheel_accelerometer.txt");
wheelT = accData.data(:,1);
wheelAT = accData.data(:,2);

A217 = wheelAT(217);
AR217 = A217/(0.75/2);

[temp, temp2] = max(wheelAT);
TimeMax = wheelT(temp2);

lagerthan5 = sum(wheelAT > 5);

vel15sec = comp_trap_vector(wheelT,wheelAT);

F15sec = 0.01 * vel15sec^2 /(0.75/2);

[A1,B1,r2] = linreg(log(wheelT(2:40)),log(wheelAT(2:40)));

A = exp(B1);
B = A1;








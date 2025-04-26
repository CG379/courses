% ENG2005 Topic 2 Vector Calculus
% Example 2.4.1 and 2.4.2, Figure 2.1 lecture notes
% Visualises the work done along two different paths from (0,0,0) to
% (1,2,5)

% The vector field F = [x-y,x+y,z+2x]
F = @(x) [x(1)-x(2); x(1)+x(2); x(3)+2*x(1)];
% Here x is a vector so x(1)='x', x(2)='y', x(3)='z'
syms t real
% interval for t
a = 0;
b = 1;

% The first path:
r1 = [t; 2*t; 5*t];
% Its tangent vector
dr1 = diff(r1,t);
% The work done
W1 = int(dot(F(r1),dr1),t,a,b);

% The second path
r2 = [t; 2*t; 5*t^2];
% Its tangent vector
dr2 = diff(r2,t);
% The work done
W2 = int(dot(F(r2),dr2),t,a,b);

% plot the paths
subplot(1,2,1)
fplot3(r1(1),r1(2),r1(3),[a,b],'b')
xlabel('x'); ylabel('y'); zlabel('z'); %axis equal
hold on
fplot3(r2(1),r2(2),r2(3),[a,b],'r')

% The points at which to plot the vectors
T = a:0.1:b;

% The first curve
R1 = double(subs(r1,t,T));
% The first curve's tangent vectors
DR1 = double(subs(dr1,t,T));
quiver3(R1(1,:),R1(2,:),R1(3,:),DR1(1,:),DR1(2,:),DR1(3,:),0.2,'Color',[0 0 0.5])
% The vector field on the first curve
FR1 = double(subs(F(r1),t,T));
quiver3(R1(1,:),R1(2,:),R1(3,:),FR1(1,:),FR1(2,:),FR1(3,:),'Color',[0 0 0.5])

% The second curve
R2 = double(subs(r2,t,T));
% The second curve's tangent vectors
DR2 = double(subs(dr2,t,T));
quiver3(R2(1,:),R2(2,:),R2(3,:),DR2(1,:),DR2(2,:),DR2(3,:),0.2,'Color',[0.5 0 0])
% The vector field on the second curve
FR2 = double(subs(F(r2),t,T));
quiver3(R2(1,:),R2(2,:),R2(3,:),FR2(1,:),FR2(2,:),FR2(3,:),'Color',[0.5 0 0])

% the integrand for the first curve
FDR1 = double(subs(dot(F(r1),dr1),t,T));
subplot(1,2,2)
area(T,FDR1,'FaceColor','b','FaceAlpha',0.5)
xlabel('t'); ylabel('$\mathbf{F}\cdot\frac{d\mathbf{r}}{dt}$','Interpreter','latex');
hold on

% the integrand for the second curve
FDR2 = double(subs(dot(F(r2),dr2),t,T));
area(T,FDR2,'FaceColor','r','FaceAlpha',0.5)
legend(sprintf('Work=%d',W1),sprintf('Work=%.2f',W2))
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                
% ENG2005 Fourier Animation
%                                              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;


%%%%%%%%%%%%%%%%%%%%% variables to be changed by user %%%%%%%%%%%%%%%%%%%%%  

f = @(x) x^2; % define function f(x) 
L = 2; % 1/2 of period, T = 2L

n_range = 0:10; % choose partial sum range
domain = [-6, 6]; range = [-20, 20]; % choose domain and range for plot

%%%%%%%%%%%%%%%%%%%%%%%%%%%% setup before plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%                               

% define symbolic variables
syms x n 
syms an(n) bn(n)

assume(n, {'integer','positive'}) % n is the group of natural numbers
% this simplifies integral computation: e.g. cos(n*pi) = (-1)^n

% find Fourier coefficients

% calculate a0
a0 = simplify( (1/(2.*L)) * int( f(x) ,[-L,L]) ) ;
% calculate an
an = simplify( (1/L) * int(f(x) * cos((n*pi)/L * x), x, [-L,L]) );

% calculate bn
bn = simplify( (1/L) * int(f(x) * sin((n*pi)/L * x), x, [-L,L]) );

% create the partial sum
f_fourier = @(k) a0 + symsum( an * cos((n*pi)/L * x) + bn * sin((n*pi)/L * x), n, 1,k);

%%%%%%%%%%%%%%%%%% plot partial sums %%%%%%%%%%%%%%%%%   

% for loop to iterate plots
for i = n_range

    % plot partial sum
    fplot(f_fourier(i),domain,'LineWidth',1.5)

    % plot features
    ax = gca; % set axes to origin
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    
    xlabel('x'); ylabel('y = f(x)'); % label axes
    xlim(domain); ylim(range) % domain and range
    
    title(sprintf(['Partial Sum up to the %ith Harmonic'],i),'FontSize',15) % title
    grid on

    pause(0.1) % delay between partial sum plots
end


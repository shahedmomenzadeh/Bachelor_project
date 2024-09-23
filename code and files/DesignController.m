clc;
clear;
close all;
%%
L = 0.4125 ; % Henry
Rl = 10 ; % ohm
Rs = 1 ; % ohm
Kf = 32654e-9 ; % N*m^2/Amp^2
g = 9810e-3 ; % m/sec^2 ;
m = 0.068 ; % kg
Xss = 10e-3 ;
Iss = Xss * sqrt(m*g/Kf)  ;
Vss = (Rl + Rs) * Iss ;
a = 2*Kf/m * Iss/Xss^2 ;
b = 2*Kf/m * Iss^2/Xss^3 ;
A = [-(Rl  + Rs)/L    0      0
    0              0        1
    -a             b        0];
B = [1/L   0   0]' ;
C = [0    1     0] ;
D = 0  ;
state_space = ss(A, B, C, D) ;
zero_pole_gain = zpk(state_space) ;
system = tf(ss(A , B , C  , D)) ;
%pidtool(system)
%sisotool(system)
n = size(A , 1) ;
Q = eye(n) ;
R = 1 ;
N = 0 ;
K = lqr(A , B , Q , R , N) ;


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

N = 1000 ;
Xss = linspace(5, 50, N)/1000 ; %divided to 1000 to convert mm to m
K = zeros(N, 3) ;
for i = 1:N
Iss = Xss(i) * sqrt(m*g/Kf)  ;
Vss = (Rl + Rs) * Iss ;

a = 2*Kf/m * Iss/Xss(i)^2 ;
b = 2*Kf/m * Iss^2/Xss(i)^3 ;
A = [-(Rl  + Rs)/L    0      0
    0              0        1
    -a             b        0];
B = [1/L   0   0]' ;
n = size(A , 1) ;
Q = eye(n) ;
R = 1 ;
N = 0 ;
K(i, :) = lqr(A , B , Q , R , N) ;
end
%%
net = feedforwardnet(5) ;
net = train(net, Xss, K') ;
Knet = net(Xss) ;
subplot(1, 2, 1)
plot(Xss, K);
title('Real output');
xlabel('Xss');
ylabel('K');
subplot(1, 2, 2)
plot(Xss, Knet);
title('Neural Network predicton')
xlabel('Xss');
ylabel('K');

gensim(net)
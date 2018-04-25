clear;
clc;

t1 = 1;
t2 = 1;
N = 10;
filename = '';
alpha = 0.5;
reachsetdyn(t1, t2, alpha, N, filename);

[fix1, fix2] = findFixPoints(alpha);
hold on;

plot(fix1, 0, 'o', 'MarkerSize', 6, 'MarkerFaceColor', [1 0 0]);
plot(fix2, 0, 'o', 'MarkerSize', 6, 'MarkerFaceColor', [0 0 1]);

% print('p1', '-dpng')
% t = 2.9, alpha = 0.011;
% t = 2, alpha = 0.05;

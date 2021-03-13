                                                 % »ñÈ¡²âÁ¿ÊýŸÝ£šŸØÕó£©
clc;
clear;
close all;
Y = csvread('.\s-9-9.csv');
y = mean(Y);
y = abs(y);
y = y / max(y);


figure;
ind = 1;
for i=1: 27,
    subplot(4, 7, i);
    m = 0;
    for j= i+1: 28,
        m(j - i) = y(ind);
        ind = ind + 1;
    end
    stem(m);
    mmm(i) = mean(m);
    axis([0 28 - i 0 1]);
end
figure();
stem(mmm);
[sys_args] = argsInitial(5);      % ³õÊŒ»¯
[xi, xt, sys_args] = ARTI(sys_args, r_c, Channel_num);
% DrawX(z_k, sidePixNum);


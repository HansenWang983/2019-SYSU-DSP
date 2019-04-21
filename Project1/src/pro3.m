clear;

dt = 4*pi/500;
f0 = 1/(2*pi);
T0 = 1/f0;
t = -2*pi:dt:2*pi;
% N = length(t);
% k = 0:N-1;
% wm = 2*pi*fm;
% w1 = k*wm/N;
w1 = linspace(-2*pi,2*pi,500);
f1 = ((1 + cos(2*pi*f0*t)) / 2) .* (abs(t) <= pi);
F1 = f1*exp(-j*t'*w1)*dt;

subplot(431),plot(t,f1);
axis([min(t)*1.1 max(t)*1.1 min(f1)*1.1 max(f1)*1.1]);
title('原连续信号');
subplot(432),plot(w1,abs(F1));
axis([-2*pi*1.1 2*pi*1.1 1.1*min(abs(F1)) 1.1*max(abs(F1))]);
title('幅度谱');

Ts = [1 pi/2 2];
% 理想低通滤波器
w = linspace(-2*pi,2*pi,500);
dw = 4*pi/500;
wc = (abs(w) <= 2.4);

for x = 1:3
    n = -2*pi:Ts(x):2*pi;
    f = ((1 + cos(2*pi*f0*n)) / 2) .* (abs(n) <= pi);
    F = f*exp(-j*n'*w)*Ts(x);

    % 与理想低通滤波器相乘进行滤波
    F = F .* wc;

    % 逆傅立叶变换还原到原信号
    t = -2*pi:dt:2*pi;
    xa = real((F*exp(j*w'*t)*dw)) / (2 * pi);

    subplot(4,3,x*3+1),stem(n,f,'filled');
    axis([min(n)*1.1 max(n)*1.1 min(f)*1.1 max(f)*1.1]);
    title(['采样周期为',num2str(Ts(x)),'的信号']);
    
    subplot(4,3,x*3+2),plot(t,xa);
    axis([-2*pi*1.1 2*pi*1.1 1.1*min(xa) 1.1*max(xa)]);
    title('采样后还原信号 fr(t)');

    subplot(4,3,x*3+3),plot(t,abs(xa-f1));
    axis([-2*pi*1.1 2*pi*1.1 1.1*min(abs(xa-f1)) 1.1*max(abs(xa-f1))]);
    title('fr(t) 与 f(t) 的绝对误差');
end



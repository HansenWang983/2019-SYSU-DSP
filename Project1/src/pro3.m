clear;

dt = 2*pi/500;
f0 = 1/(2*pi);
T0 = 1/f0;
t = -pi:dt:pi;
% N = length(t);
% k = 0:N-1;
% wm = 2*pi*fm;
% w1 = k*wm/N;
w1 = linspace(-2*pi,2*pi,500);
f = (1 + cos(2*pi*f0*t)) / 2;
F1 = f*exp(-j*t'*w1)*dt;

subplot(431),plot(t,f);
axis([min(t)*1.1 max(t)*1.1 min(f)*1.1 max(f)*1.1]);
title('原连续信号');
subplot(432),plot(w1,abs(F1));
axis([-2*pi*1.1 2*pi*1.1 1.1*min(abs(F1)) 1.1*max(abs(F1))]);
title('幅度谱');

Ts = [1 pi/2 2];

for x = 1:3
    n1 = -pi:Ts(x):pi;
    % 抽样信号
    f1 = (1 + cos(2*pi*f0*n1)) / 2;
    % 生成 n 序列
    n = -pi/Ts(x):pi/Ts(x);
    % 生成 t 序列
    t1 = -pi:dt:pi;
    % 生成 f(n*Ts(x))
    x1 = (1+cos(2*pi*f0*n*Ts(x))) / 2;
    % 生成 t-nT 矩阵
    t_nT = ones(length(n),1)*t1-n'*Ts(x)*ones(1,length(t1));
    % 内插公式
    xa = x1*Ts(x)/pi*(sin(2.4*t_nT)./(t_nT));

    subplot(4,3,x*3+1),stem(n1,f1,'filled');
    axis([min(n1)*1.1 max(n1)*1.1 min(f1)*1.1 max(f1)*1.1]);
    title(['采样周期为',num2str(Ts(x)),'的信号']);
    
    subplot(4,3,x*3+2),plot(t1,xa);
    axis([-pi*1.1 pi*1.1 1.1*min(xa) 1.1*max(xa)]);
    title('采样后还原信号 fr(t)');

    subplot(4,3,x*3+3),plot(t1,abs(xa-f));
    axis([-2*pi*1.1 2*pi*1.1 1.1*min(abs(xa-f)) 1.1*max(abs(xa-f))]);
    title('fr(t) 与 f(t) 的绝对误差');
end



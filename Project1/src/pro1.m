clear;

% 连续信号
% 时间间隔
Ts = 4*pi/500;
% 时间序列
t = -2*pi:Ts:2*pi;
% 采样点个数
N = length(t);
% 1 x N
f = ((1 + cos(t)) / 2) .* (abs(t) <= pi);
% 频率采样序列
k = 0:N-1;
w = (2*pi*k)/(N*Ts);
% w = linspace(-2*pi,2*pi,500) ;
%  N x N
e = exp(-j*t'*w);
% 1 x N
F1 = f*e*Ts;
subplot(311),plot(t,f);
axis([min(t)*1.1 max(t)*1.1 min(f)*1.1 max(f)*1.1]);
title('原连续信号');
subplot(312),plot(w,abs(F1));
axis([min(w)*1.1 max(w)*1.1 min(abs(F1))*1.1 max(abs(F1))*1.1]);
title('幅度谱');
subplot(313),plot(w,angle(F1));
axis([min(w)*1.1 max(w)*1.1 1.1*min(angle(F1)) 1.1*max(angle(F1))]);
title('相位谱');

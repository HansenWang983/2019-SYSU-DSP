clear;

dt = 0.001;
f0 = 1/(2*pi);
T0 = 1/f0;
t = -2*pi:dt:2*pi;
w1 = linspace(-2*pi,2*pi,500);
f = ((1 + cos(2*pi*f0*t)) / 2) .* (abs(t) <= pi);
F1 = f*exp(-j*t'*w1)*dt;
subplot(431),plot(t,f);
axis([min(t)*1.1 max(t)*1.1 min(f)*1.1 max(f)*1.1]);
title('原连续信号');
subplot(432),plot(w1,abs(F1));
axis([-2*pi*1.1 2*pi*1.1 1.1*min(abs(F1)) 1.1*max(abs(F1))]);
title('幅度谱');
subplot(433),plot(w1,angle(F1));
axis([-2*pi*1.1 2*pi*1.1 1.1*min(angle(F1)) 1.1*max(angle(F1))]);
title('相位谱');

% sampling period
Ts = [1 pi/2 2];

for x = 1:3
    n = -pi:Ts(x):pi;
    w = linspace(-2*pi,2*pi,500);
    f = ((1 + cos(2*pi*f0*n)) / 2) .* (abs(n) <= pi);
    F = f*exp(-j*n'*w)*Ts(x);
    
    subplot(4,3,x*3+1),stem(n,f,'filled');
    axis([min(n)*1.1 max(n)*1.1 min(f)*1.1 max(f)*1.1]);
    title(['采样周期为',num2str(Ts(x)),'的信号']);
    
    subplot(4,3,x*3+2),plot(w,abs(F));
    title('幅度谱');

    subplot(4,3,x*3+3),plot(w,angle(F));
    title('相位谱');
end



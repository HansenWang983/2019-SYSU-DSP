[TOC]

# Project 1

![1](Assets/1.jpg)

## A

Plot this signal and its frequency spectrum;

### 实现过程和结果

利用连续时间信号傅立叶变换的数值计算方法，根据 CTFT ，当 $\tau$ （时间间隔，即采样周期）取足够小的时候，可以得到如下近似

![2](Assets/2.jpg)

因为上述信号是时限的，i.e. 当 t < $-\pi$ 或者 t > $\pi$ 时，f(t) 为 0。所以上式中的 n 取值是有限的，设为 N，有：

![3](Assets/3.jpg)

其中 n$\tau​$ 为采样时间序列，$\omega_k​$ 为角速度的序列

对角速度 $\omega​$ 进行取样：

![4](Assets/4.jpg)

最后对于将 n$\tau$ 转置为 Nx1 的列向量并且和 1xN 的行向量 $\omega_k$ 进行内积并根据 （2）式得到 1xN 的结果。

代码如下：

```matlab
clear;

% 连续信号
% 时间间隔
Ts = 2*pi/500;
% 时间序列
t = -pi:Ts:pi;
% 采样点个数
N = length(t);
% 1 x N
f = (1 + cos(t)) / 2;
% 频率采样序列
k = 0:N-1;
w = (2*pi*k)/(N*Ts);
% w1 = -2*pi:0.001:2*pi ;
%  N x N
e = exp(-j*t'*w);
% 1 x N
F1 = f*e*Ts;
subplot(311),plot(t,f);
axis([min(t)*1.1 max(t)*1.1 min(f)*1.1 max(f)*1.1]);
title('原连续信号');
subplot(312),plot(w,abs(F1));
axis([min(w)*1.1 max(w)*1.1 min(abs(F1))*1.1 max(abs(F1))*1.1]);
title('频谱');
subplot(313),plot(w,angle(F1));
axis([min(w)*1.1 max(w)*1.1 1.1*min(angle(F1)) 1.1*max(angle(F1))]);
title('相位谱');
```

输出结果：

![5](Assets/5.jpg)

由于按照时域信号的采样频率 $500/2\pi$ 绘制幅度谱和相位谱 ， 导致横坐标范围过大，远远超过原信号中的最大带宽，故将范围缩小为 $(-2\pi,2\pi)$ 。

```matlab
w = linspace(-2*pi,2*pi,500) ;
```

![6](Assets/6.jpg)





## B

When the sampling period satisfies T = 1 ， T = p / 2 ， T = 2 , respectively, please plot the sampling signal f p (n) and its frequency spectrum, respectively. Please give explanation of these results;

### 实现过程和结果

首先对原连续信号进行采样，然后使用 DTFT，i.e. 信号在时域上是离散的、非周期的，而在频域上则是连续的、周期性的。

![7](Assets/7.jpg)

代码

```matlab
clear;

dt = 2*pi/500;
f0 = 1/(2*pi);
T0 = 1/f0;
t = -pi:dt:pi;
w1 = linspace(-2*pi,2*pi,500);
f = (1 + cos(2*pi*f0*t)) / 2;
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
    f = (1 + cos(2*pi*f0*n)) / 2;
    F = f*exp(-j*n'*w)*dt;
    
    subplot(4,3,x*3+1),stem(n,f,'filled');
    axis([min(n)*1.1 max(n)*1.1 min(f)*1.1 max(f)*1.1]);
    title(['采样周期为',num2str(Ts(x)),'的信号']);
    
    subplot(4,3,x*3+2),plot(w,abs(F));
    title('幅度谱');

    subplot(4,3,x*3+3),plot(w,angle(F));
    title('相位谱');

end
```

结果如下：

![8](Assets/8.jpg)

离散时间信号大多由连续时间信号(模拟信号)抽样获得，时域信号的离散会导致频域的周期延拓，只有满足不低于信号最高频率两倍的采样频率采样，才不会导致频域周期延拓后的混叠，才有可能不失真地恢复源信号。 假设有限带宽信号 xa(t) 的最高频率为 fm，抽样信号 fp(t) 的周期 Ts 及抽样频率 Fs 的取值必须符合奈奎斯特 (Nyquist) 定理：Fs ≥ 2fm，才不会发生混叠现象。

如上图所示，当采样周期为 1 和 $\pi/2$ 时，不会发生混叠，并且当采样周期为 $\pi/2$ 时为临界采样；而当采样周期为 2 时，频谱出现了镜像对称的部分，且对称点的幅度值不为 0 ，说明高频部分混叠到已有低频部分，造成高频消失，这是由于欠采样造成的混叠现象，因此无法重建原信号。





## C

Using lowpass filter with cutting frequency wc = 2.4 to reconstruct signal fr (t ) from fp (n) . When the sampling period satisfies T = 1 ， T = 2 , respectively, please plot the reconstructed signal fr (t ) , and plot the absolute error between the reconstructed signal fr (t ) and the original signal f (t ) . Please analyze these results.

### 实现过程和结果

在频域上看，恢复信号就是用一个理想低通滤波器与时域信号的频谱相乘，以得到频域的第一个周期，而频域的理想低通滤波器，也就是频域矩形窗，经过傅里叶逆变化后在时域是无限长的内插函数，是非因果的 ，由于频域相乘对应着时域卷积，信号重建可以用时域信号与内插函数进行卷积积分来求解。公式如下：

![10](Assets/10.jpg)

代码：

```matlab
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
    axis([-2*pi*1.1 2*pi*1.1 1.1*min(xa) 1.1*max(xa)]);
    title('采样后还原信号 fr(t)');

    subplot(4,3,x*3+3),plot(t1,abs(xa-f));
    axis([-2*pi*1.1 2*pi*1.1 1.1*min(abs(xa-f)) 1.1*max(abs(xa-f))]);
    title('fr(t) 与 f(t) 的绝对误差');
end
```

结果如下：

![9](Assets/9.jpg)

发现对于采样周期为 1 和 $\pi/2$ 的离散信号，可以较为准确地重建到原信号，但仍然与原信号存在绝对误差，且低频的绝对误差小于高频的，后者的绝对误差相比前者的大，这是由于原始的模拟信号 xa（t）不是严格带限产生的，即不存在最高带宽 wm，在频谱图上表示为当 w > wm 时，幅度值为 0，所以低通滤波器的截止频率未能满足：

![11](Assets/11.jpg)

故未保留全部的高频信息，能完全恢复到原始模拟信号。

而对于采样周期为 2 的离散信号，误差在低频和高频都很大，说明这不满足可以重构的第二个条件：频谱未发生混叠，导致一些低频成分和高频成分的同时丢失。


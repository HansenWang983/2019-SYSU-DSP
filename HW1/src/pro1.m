clear;

n = input('Input the number of continuous-time signal you wanna draw:\n');

% 频率
frequency = [];
% 振幅
Um = [];
% 采样频率
sf = input('Input the sampling rate:\n');
% 离散信号的采样点序列
dt = linspace(0,1,sf+1);
for x = 1:n
    frequency(x) = input('Input the frequency of the cos(x):\n');
    Um(x) = input('Input the amplitude of the cos(x):\n');
    nn = linspace(0,1,50*frequency(x));
    xx = Um(x) * cos(2 * pi * frequency(x) * nn);
    hold on
    plot(nn,xx,'DisplayName',[num2str(Um(x)),'*cos(',num2str(2*frequency(x)),'*pi*x)']);
    axis([0, 1, 1.1 * min(xx), 1.1 * max(xx)]);
    xlabel('time');
    ylabel('ampltitude');
    % 离散正弦信号
    dx = Um(x) * cos(2 * pi * frequency(x) * dt);
    stem(dt,dx,'DisplayName','Sampled version of above signal');
end
legend


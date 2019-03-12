function [n,nn,x,xx] = conti_sin(Um,frequency,sf)
    % generate continuous-time sinusoidal signal
    
    nn = linspace(0,1,32*frequency);
    xx = Um * cos(2 * pi * frequency * nn);
    % 离散信号的采样点序列
    n = linspace(0,1,sf+1);
    % 离散正弦信号
    x = Um * cos(2 * pi * frequency * n);

    hold on
    plot(nn,xx);
    axis([0, 1, 1.1 * min(xx), 1.1 * max(xx)]);
    ylabel('x(t)');
    
    stem(n,x);
    axis([0, 1 , 1.1 * min(x), 1.1 * max(x)]);
    ylabel('x(n)');
end
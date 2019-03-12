clear;

frequency = [3 7 13];
% 振幅
Um = [1 1 1];
% 采样频率
sf = 10;
% 显示周期数
% nt = [1 1];
% 一个周期的采样点数
% N = [32 32];

[n1,nn1,x1,xx1] = conti_sin(Um(1),frequency(1),sf);
[n2,nn2,x2,xx2] = conti_sin(Um(2),frequency(2),sf);
[n3,nn3,x3,xx3] = conti_sin(Um(3),frequency(3),sf);

% ax1 = subplot(211);   
% plot(ax1,nn1,xx1);
% axis([0, 1, 1.1 * min(xx1), 1.1 * max(xx1)]);
% ylabel('x(t)');

% ax2 = subplot(212);
% stem(ax2,n1,x1);
% axis([0, 1 , 1.1 * min(x1), 1.1 * max(x1)]);
% ylabel('x(n)');

% hold(ax1,'on')
% plot(ax1,nn2,xx2);
% ylabel('x(t)');

% hold(ax2,'on')    
% stem(ax2,n2,x2);
% ylabel('x(n)');

% hold(ax1,'on')
% plot(ax1,nn3,xx3);
% ylabel('x(t)');

% hold(ax2,'on')
% stem(ax2,n3,x3);
% ylabel('x(n)');
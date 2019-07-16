clear;

% 采样频率
Fs = 15;
% 数字滤波器的通带截止频率
fp = 3;
% 数字滤波器的阻带截止频率
fs = 5;
% 通带波纹系数
rp = 0.3;
% 阻带波纹系数
rs = 40;

ws = fs/(Fs/2);
wp = fp/(Fs/2);

[n,wn] = ellipord(wp,ws,rp,rs);
[b,a] = ellip(n, rp, rs, wn);
freqz(b,a);
% [H, W] = freqz(b,a);
% dbH = 20 * log10(abs(H)/max(abs(H)));
% plot(W/2/pi*Fs, dbH, 'k');

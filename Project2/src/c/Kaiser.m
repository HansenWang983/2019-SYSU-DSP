clear;

wp = 2*pi * 3/15; 
ws = 2*pi * 5/15; 

wc = (ws+wp) / 2;
delt_w = ws - wp;

rp = 0.3; 
rs = 40;

N = ceil((rs - 8) / (delt_w * 2.285));
M = (N-1) / 2;
win = kaiser(N);
n = -M:M;
filter_t = fir1(N-1, wc/pi, win);

subplot(1,2,1);
plot(n,filter_t,'.-')
title("Kaiser: the actual impulse response"); 

[h,w] = freqz(filter_t,1,512); 
W = w/pi; 
H = 20*log10(abs(h));

subplot(1,2,2);
plot(W,H);
title("the gain response");


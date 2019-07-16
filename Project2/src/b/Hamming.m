clear;

wp = 2*pi * 3/15; 
ws = 2*pi * 5/15; 

rp = 0.3; 
rs = 40;

c = 3.32*pi;

wc = (ws+wp) / 2;
delt_w = ws - wp;

M = ceil(c / delt_w);
N = 2 * M + 1;
win = hamming(N);
n = -M:M;
hd = sin(wc*n)./(pi*n);
hd(find(n==0)) = wc*cos(wc*0)/pi;
ht = hd.*win';

subplot(1,3,1);
plot(n,hd,'.-');
title("Hamming: the ideal impulse response");

subplot(1,3,2);
plot(n,ht,'.-')
title("Hamming: the actual impulse response"); 

[h,w] = freqz(ht,1,512); 
W = w/pi; 
H = 20*log10(abs(h));

subplot(1,3,3);
plot(W,H);
title("the gain response");


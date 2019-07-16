clear;

wp = 2*pi * 3/15; 
ws = 2*pi * 5/15; 

wc = (ws+wp) / 2;
delt_w = ws - wp;

c = 5.56*pi;

M = ceil(c / delt_w);
N = 2 * M + 1;
win = blackman(N);
n = -M:M;
hd = sin(wc*n)./(pi*n);
hd(find(n==0)) = wc*cos(wc*0)/pi;
ht = hd.*win';

subplot(1,3,1);
plot(n,hd,'.-');
title("Blackman: the ideal impulse response");

subplot(1,3,2);
plot(n,ht,'.-')
title("Blackman: the actual impulse response"); 

[h,w] = freqz(ht,1,512); 
W = w/pi; 
H = 20*log10(abs(h));

subplot(1,3,3);
plot(W,H);
title("the gain response");


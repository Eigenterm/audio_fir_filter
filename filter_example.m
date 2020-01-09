% clear;clc;
% author: Kimchange 3017207458
% hn = fir_filter(0,0,0.2*pi,0.4*pi,30);            % ��ͨ
% hn = fir_filter(0.2*pi,0.4*pi,pi,pi,50);          % ��ͨ
% hn = fir_filter(0.1*pi,0.2*pi,0.6*pi,0.8*pi,50);    % ��ͨ

[H,w] = freqz(hn_HPF,1,1000,'whole');
% H = (H(1:1:501))'; %ֻȡ 0��pi ����
% w = (w(1:1:501))'; %ֻȡ 0��pi ����
mag = abs(H);
db = 20*log10((mag + eps) / max(mag));

plot(w/pi,db); title('������Ӧ'); grid;
axis([0 1 -100 10]); xlabel('Ƶ��(��λ pi)'); ylabel('dB');
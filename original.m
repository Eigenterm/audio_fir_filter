clear;clc;close all;
[x,Fs] = audioread('chirp.wav');
sound(x,Fs);
N=length(x);
subplot(3,1,1);plot(x);title('原始信号波形');
subplot(3,1,2);
Hs=spectrum.welch;
psd(Hs,x,'Fs',Fs);title('功率图');
subplot(3,1,3);
y=fft(x,N);
df = Fs/N;
f = 0:df:df*(round(N/2)-1);
Xk=abs(y)/N;
Xk(1) = Xk(1)*2;
plot(f,Xk(1:round(N/2)));title('幅度图');
axis([0 Fs/2 0 max(Xk)*1.2]); xlabel('频率(单位：Hz)'); ylabel('幅度值');
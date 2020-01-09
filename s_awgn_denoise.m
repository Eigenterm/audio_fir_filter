%% add awgn
clear;clc;close all;
[x,Fs] = audioread('chirp.wav');
N=length(x);

subplot(2,4,1);
plot(x);title('ԭʼ�źŲ���');

y=fft(x,N);
df = Fs/N;
f = 0:df:df*(round(N/2)-1);
Xk=abs(y)/N;
Xk(1) = Xk(1)*2;
subplot(2,4,5)
plot(f,Xk(1:round(N/2)));title('ԭʼ�źŷ�����');
axis([0 Fs/2 0 max(Xk)*1.2]); xlabel('Ƶ��(��λ��Hz)'); ylabel('����ֵ');

x_awgn = awgn(x,20);
subplot(2,4,2);
plot(x_awgn);title('���������źŵ�ʱ����');

y_awgn = fft(x_awgn,N);
Xk_awgn=abs(y_awgn)/N;
Xk_awgn(1) = 2*Xk_awgn(1);
subplot(2,4,6);
plot(f,Xk_awgn(1:round(N/2)));title('���������źŵķ�����');
axis([0 Fs/2 0 max(Xk_awgn)*1.2]); xlabel('Ƶ��(��λ��Hz)'); ylabel('����ֵ');

%% denoise  ʹ��BPF
ws1 = 2*pi*2000/Fs;                     % �����ֹƵ��2000Hz
wp1 = 2*pi*2200/Fs;                     % ͨ����ֹƵ��2200Hz
wp2 = 2*pi*4000/Fs;                     % ͨ����ֹƵ��4000Hz
ws2 = 2*pi*4090/Fs;                     % �����ֹƵ��4090Hz
alphaS = 50;                            % �����С˥��

hn_BPF = fir_filter(ws1,wp1,wp2,ws2,alphaS);
x_denoise_BPF = filter(hn_BPF,1,x_awgn);
subplot(2,4,3);
plot(x_denoise_BPF);title('BPF�˲����ʱ����');

y_denoise_BPF = fft(x_denoise_BPF,N);
Xk_denoise_BPF=abs(y_denoise_BPF)/N;
Xk_denoise_BPF(1) = 2*Xk_denoise_BPF(1);
subplot(2,4,7);
plot(f,Xk_denoise_BPF(1:round(N/2)));title('BPF�˲���ķ�����');
axis([0 Fs/2 0 max(Xk_denoise_BPF)*1.2]); xlabel('Ƶ��(��λ��Hz)'); ylabel('����ֵ');


% HPF
ws1_HPF = 2*pi*2000/Fs;                     % �����ֹƵ��2000Hz
wp1_HPF = 2*pi*2200/Fs;                     % ͨ����ֹƵ��2200Hz
wp2_HPF = pi;
ws2_HPF = pi;                               %��ͨ

hn_HPF = fir_filter(ws1_HPF,wp1_HPF,wp2_HPF,ws2_HPF,alphaS);
x_denoise_HPF = filter(hn_HPF,1,x_awgn);
subplot(2,4,4);
plot(x_denoise_HPF);title('HPF�˲����ʱ����');

y_denoise_HPF = fft(x_denoise_HPF,N);
Xk_denoise_HPF=abs(y_denoise_HPF)/N;
Xk_denoise_HPF(1) = 2*Xk_denoise_HPF(1);
subplot(2,4,8);
plot(f,Xk_denoise_HPF(1:round(N/2)));title('HPF�˲���ķ�����');
axis([0 Fs/2 0 max(Xk_denoise_HPF)*1.2]); xlabel('Ƶ��(��λ��Hz)'); ylabel('����ֵ');

sound(x,Fs);
pause(2);
sound(x_awgn,Fs);
pause(2);
sound(x_denoise_BPF,Fs);
pause(2);
sound(x_denoise_HPF,Fs);

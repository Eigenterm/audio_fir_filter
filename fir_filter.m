function hn = fir_filter(ws1,wp1,wp2,ws2,alphaS)
% author: Kimchange 3017207458 from TJU
% ���� �Ǵ��� �˲������
% ws1, wp1, wp2, ws2 ���β��ݼ�,��λ����rad
% wp1 = 0�� ��Ϊ����������λ��ͨ�˲���
% wp2 = pi����Ϊ����������λ��ͨ�˲�����
% --------------------------------

%  alphaS = �����С˥��dB,��Ϊ������80dB
%

% Band ���ɴ����
if wp1 == 0
    Band = (ws2 - wp2);
elseif wp2 == pi
    Band = (wp1 - ws1);
else 
    Band = min( (ws2 - wp2) ,(wp1 - ws1) );
end


alphaS = abs(alphaS);
if alphaS <= 21
    M = 1.8*pi/Band;
    M = floor( ceil(M)/2 )*2+1;            % ȡ���ڵ���M����С����
    win = rectwin(M);                      % ���δ�
elseif alphaS > 21 & alphaS <= 25
    M = 6.1*pi/Band;
    M = floor( ceil(M)/2 )*2+1;            % ȡ���ڵ���M����С����
    win = bartlett(M);                     % ���Ǵ�
elseif alphaS > 25 & alphaS <= 44
    M = 6.1*pi/Band;
    M = floor( ceil(M)/2 )*2+1;            % ȡ���ڵ���M����С����
    win = hanning(M);                      % ������
elseif alphaS > 44 & alphaS <= 53
    M = 6.6*pi/Band;
    M = floor( ceil(M)/2 )*2+1;            % ȡ���ڵ���M����С����
    win = hamming(M);                      % ������
elseif alphaS > 53 & alphaS <= 74
    M = 11*pi/Band;
    M = floor( ceil(M)/2 )*2+1;            % ȡ���ڵ���M����С����
    win = blackman(M);                     % ����������
else
    M = 10*pi/Band;
    M = floor( ceil(M)/2 )*2+1;            % ȡ���ڵ���M����С����
    win = kaiser(M,7.865);                 % ������
end
    

M = double(M);
alpha = (M-1)/2;
n = [0:1:(M-1)];
m = n - alpha + eps;
hdn = ( sin( (wp2+ws2)/2 *m) - sin((wp1+ws1)/2 *m) ) ./ (pi*m);
hn = hdn.*win';
end



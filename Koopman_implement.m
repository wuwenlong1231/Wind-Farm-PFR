clear

M=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.15����.xlsx','���1Ƶ���½�M');
C=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.15����.xlsx','���1Ƶ���½�C');
% C=C';
D=50;
%��������
windspeed=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','sheet1','A2:B17');
wspeed1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','sheet1','C2:C17');
% wspeed2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','sheet1','D2:D17');
wspeed1=wspeed1';

% Kf=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','sheet1','E2:E17');
Kfi1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','�½����1ϵ��');
% Kfi2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','�������2ϵ��');
% Pei1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','sheet1','G2:G17');
% Pei2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','sheet1','H2:H17');
% Pei1=Pei1';
% Pei2=Pei2';
H=299;
[n,m]=size(windspeed);%nΪ��������֤����
frequency(1,1:n)=50;
% wait_title = waitbar(0,'Please Wait'); 
% load(['D:\�����ڼ���ֲ���\MATLAB����\PES����\10.13PES����\Ƶ���½���һ���ṹ��\�����һ��.mat']);
% load(['D:\�����ڼ���ֲ���\MATLAB����\PES����\10.13PES����\Ƶ���½���һ���ṹ��\�����һ��.mat']);
wspeed1(1,1)=[0.817715131640888];
windspeed(1,1)=[7.20368092159830];
Kfi1(1,1)=1.3;
for z=1:1%n
    X1(1,1)=wspeed1;%
    X1(2,1)=wspeed2;%
    X1(3,1)=frequency;%\
    X1(4,1)=Kf1;%
    X1(5,1)=Kf2;%
    X1(6,1)=windspeed1;%�˴���ʹ��SOE��Kfi���ݽ���ѵ����
    X1(7,1)=windspeed2;%
    %��ά�۲���������
    [r,t]=size(X1);
    for a=1:D
        for b=1:r%����������ά��
            f1(1,b)=(X1(b,1)-C(a,b))^2;
        end
      f2=sum(f1,2)^0.5;
     X2(a,1)=exp(-(1*f2)^2);
    end
    X=[X1(1:3,:);X2;X1(4:7,:)];
    [a,b]=size(X);
  for i=1:H%����ģ�͹���Ԥ��
    M1=M((i-1)*(D+2)+1:i*(D+2),:);
    Y=M1*X;%��ʱYΪ��һ����ֵ
    wspeed3(i,1)=Y(1,1);%�������
    wspeed4(i,1)=Y(2,1);
    frequency1(i,1)=Y(2,1);
    X(1:a-4,1)=Y;%�����������״̬
  end 
  disp(wspeed3(H,:));
  disp(wspeed4(H,:));
end
figure(1)
plot(frequency1);
figure(2)
plot(wspeed3);

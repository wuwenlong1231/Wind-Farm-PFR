clc
clear
windspeed=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\����.xlsx','sheet1','A2:B16');
[a,b]=size(windspeed);
f1=1.27;
H=300;
N=8;
M=50;
R=55.5;%59.5 75
for j=1:1%a
for i=1:4
    X2(1,i)=windspeed(j,1);
    X2(1,i+4)=windspeed(j,2);
end
 [Kf1(j,1),Kfi]=Kf_w(windspeed(j,:),f1);%��������Kf��ֵ
 speed=ones(1,N);
 [wspeed(1,:),Pm(1,:)]=Cpmax(speed,X2,R,a);
 Pm0=Pm(1,1);
 wspeed0=wspeed(1,:);
 wspeed1=wspeed(1,:);
frequency1=50;
for i=1:H
[frequency,Pei,Kfi]=roll_up(X2,Kf1(j,1),i,wspeed1,frequency1);
[Kfi2(i,1)]=optimal(frequency(1:M,1),wspeed0,Pm0,Pei(1:M,1));%����ģ�͵õ�ת����ΪԼ��
wspeed1=wspeed(2,:);
frequency1=frequency(2,:);

end
[wspeed,frequency2,Pe,Pei,Pe2,SOE,Pm] = Windfarm_up(X2,Kf1(j,1));%���ȸ�����һЩ�ο�ֵ
[wspeed2,Pei2]=operate(Kfi,Pm,frequency2);

end

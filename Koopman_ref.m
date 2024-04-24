clc
clear
%%
%ѵ��ģ�ͣ�����Ϊ2���١�kin��kf�����ΪPL��2��w
data=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\���ǹ������´�ϵ��\����.xlsx','Ƶ������1MW����','A3:G4002');
data=data';
 input(1,:)=data(1,:);
 input(2,:)=data(2,:);
 input(3:4,:)=data(3:4,:);%����
 output(1,:)=data(5,:);
 output(2:3,:)=data(6:7,:);
[inputn,inputs]=mapminmax(input,0,1);
[outputn,outputs]=mapminmax(output,0,1);
PL1=outputn(1,:);%���Kin
wspeed1=outputn(2:3,:);%���Kin
Kin1=inputn(1,:);
Kf1=inputn(2,:);
windspeed=inputn(3:4,:);
D=500;%�½�����ά��200������500ά
C=zeros(D,4);%������������
i2=8;%������
i3=0.5;%���䳤��
i4=-2;%������˵�
for i=1:4
%     for i1=1:8
%      C(:,1)=0.1:30.9/(D-1):31;
%      C(:,2)=0.1:83.9/(D-1):84;
%      C(:,3)=7:(11-7)/(D-1):11;
%      C(:,4)=7:(11-7)/(D-1):11;
%      C1(1+D*(i1-1)/i2:D*i1/i2,i)=i4+(i1-1)*i3+i3*rand(D/i2,1);
%     end
%      C1(1:D/4,i)=-2+1*rand(D/4,1);
%      C1(D/4+1:D/2,i)=-1+1*rand(D/4,1);
%      C1(D/2+1:D*3/4,i)=0+1*rand(D/4,1);
%      C1(D*3/4+1:D,i)=1+1*rand(D/4,1);
 C1(:,i)=-2+4*rand(D,1);
%   C1(:,i)=0.1:2.9/(D-1):3;

end
% C1=mapminmax('apply',C',inputs);
% C1=C1';
C1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\���ǹ������´�ϵ��\ģ�Ͳ���.xlsx','����1MW_C');
% [M]=solveM(Kin1,Kf1,windspeed,PL1,wspeed1,C1,D);%��һ����ѵ����M
M=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\���ǹ������´�ϵ��\ģ�Ͳ���.xlsx','����1MW_M');
f1=1;%����Լ��1MW
f2=1.3;%ת��Լ��
i=1;
Kf2(1,1)=0;
% windspeed2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\���ǹ������´�ϵ��\��άͼ.xlsx','���ݶԳ�','A3:B27');
% windspeed2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\���ǹ������´�ϵ��\��άͼ.xlsx','���ݶԳ�','G3:H15');
windspeed3=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\���ǹ������´�ϵ��\����.xlsx','Ƶ������1MW����','B2:C17');
windspeed2=windspeed3(1,:);
windspeed2=windspeed2';
[Q,N]=size(windspeed2); 
for m=1:N
windspeed1=windspeed2(:,m);
Kf_process(m,i)=Kf2(1,1);

while(1)
[Kin2(1,i+1),PL]=erfen_koopman_PL(Kf2(1,i),windspeed1,f1,M,C1,D,inputs,outputs,m);
[Kf2(1,i+1),wspeed]=erfen_koopman_wspeed(Kin2(1,i+1),windspeed1,f2,M,C1,D,inputs,outputs,m);
Kin_process(m,i)=Kin2(1,i+1);
Kf_process(m,i+1)=Kf2(1,i+1);
 if abs(Kin2(1,i+1)-Kin2(1,i))<=0.01&&abs(Kf2(1,i+1)-Kf2(1,i))<=0.01
     i=i+1;
     break 
 end
 i=i+1;
end
Kin3(m,1)=Kin2(1,i);
Kf3(m,1)=Kf2(1,i);
i=1;
end
windspeed2=windspeed2';
[Q,N]=size(windspeed2);
for j=1:Q
  x2=windspeed2(j,:);
for i=1:4
    X2(1,i)=x2(1,1);
    X2(1,i+4)=x2(1,2);
end 
Kf1=Kf3(j,1);
Kin1=Kin3(j,1);
[wspeed1,frequency,Pe,Pei,Pe2,SOE,Pm,delta_Pf] =Windfarm_up(X2,Kf1,Kin1);
H=3000;
F=(frequency(2,1)-frequency(1,1))/0.01;
Pe_del(j,1)=f1-abs(Pe(2,1)-Pe(1,1))/1000000;
wspeed_del(j,1)=f2-wspeed1(H+1,4);%Ƶ������
wspeed_del(j,2)=f2-wspeed1(H+1,8);
% wspeed_del(j,1)=wspeed1(H+1,4)-f2;%Ƶ���½�
% wspeed_del(j,2)=wspeed1(H+1,8)-f2;
end
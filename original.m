clc
clear
windspeed=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','��άͼ','A2:B14');
Kf=1;
[a,b]=size(windspeed);
f1=0.7;%���Լ��޳���
for j=1:a
for i=1:10
    X2(1,i)=windspeed(j,1);
    X2(1,i+10)=windspeed(j,2);
    Kfi_N(1,i)=0;
    Kfi_N(1,i+10)=0;
end
 [wspeed,frequency,Pe,Pei] = Windfarm_down_new(X2(1,:),Kfi_N(1,:));
wspeed0(j,1)=wspeed(1,1);
wspeed0(j,2)=wspeed(1,11);

% [wspeed,frequency,Pe,Pei,Pe2,SOE,Pm] = Windfarm_up(X2,Kf);
% wspeed1(j,1)=wspeed(1,1);
% wspeed1(j,2)=wspeed(1,8);
%  [Kf1(j,1),Kfi,Pei0]=Kf_w(windspeed(j,:),f1);
% Kfi2(:,j)=Kfi(:,4);
% Kfi3(:,j)=Kfi(:,8);
% Pei1(j,1)=Pei0(1,4);
% Pei2(j,1)=Pei0(1,8);

end



clear
clc
syms Kf1 Kf2 f3
M=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.9����.xlsx','Ƶ������M');
C=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.9����.xlsx','Ƶ������Cת��');
% C=C';
D=100;
%��������
windspeed=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','sheet1','A2:B17');
wspeed1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','sheet1','C2:C17');
wspeed2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','sheet1','D2:D17');
wspeed1=wspeed1';
wspeed2=wspeed2';
Kf=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','sheet1','E2:E17');
Kfi1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','�������1ϵ��');
Kfi2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','�������2ϵ��');
Pei1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','sheet1','G2:G17');
Pei2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','sheet1','H2:H17');
Pei1=Pei1';
Pei2=Pei2';
H=299;
[n,m]=size(windspeed);%nΪ��������֤����
frequency(1,1:n)=50;
wait_title = waitbar(0,'Please Wait'); 

for z=1:n%n
       for j=1:4
        X2(1,j)=windspeed(z,1);
        X2(1,j+4)=windspeed(z,2);
       end
      [wspeed,frequency1,Pe,Pei,Pe2,SOE,Pm]=Windfarm_up(X2,Kf(z,1));
  for i=1:1
     load(['D:\�����ڼ���ֲ���\MATLAB����\PES����\10.9PES����\Ƶ��������һ���ṹ��\�����һ��',num2str(i),'.mat']);
     load(['D:\�����ڼ���ֲ���\MATLAB����\PES����\10.9PES����\Ƶ��������һ���ṹ��\�����һ��',num2str(i),'.mat']);
    M1=M((i-1)*5+1:i*5,:);
    C1=C;
    X1(1,1)=wspeed1(i,z);%
    X1(2,1)=wspeed2(i,z);%
    X1(3,1)=0;%
    X1(4,1)=0;%
    X1(5,1)=windspeed(z,1);%?
    X1(6,1)=windspeed(z,2);%?
    X1(7,1)=frequency(i,z);%����
    X1n=mapminmax('apply',X1,inputs);
    for i=1:7
        A(i,1)=X1n(i,1);
    end
    for a=1:1%1
        for b=1:2%����������ά��
%             f1(1,b)=(X1n(b,1)-C1(a,b))^2;
            f1(1,b)=(X1n(b,1)-C1(a,b))^2;
        end
        for b=3:4
            f1(1,b)=0;
        end
        for b=5:7
            f1(1,b)=(X1n(b,1)-C1(a,b))^2;
        end
        f_2=sum(f1,2);
      f2=(sum(f1,2)+(Kf1-C1(a,3))^2+(Kf2-C1(a,4))^2)^0.5;
%      X2n(a,1)=f2*log(f2);
     f3=f2*log(f2);
     Functions=taylor(f3,[Kf1 Kf2],[1,1],'order',2);  %f3=f2
    end
  end
end
% %     X=[X1n;X2n];
%     X=[X1n;X2n];
%     Y=M1*X;
%     Yn=mapminmax('reverse',Y,outputs);
%      wspeed_del1(i,z)=Yn(1,1);
%      wspeed_del2(i,z)=Yn(2,1);
%      Pei_del1(i,z)=Yn(3,1);
%      Pei_del2(i,z)=Yn(4,1);
%      f_del(i,z)=Yn(5,1);
% %     wspeed_del(i,z)=mapminmax('reverse',Y,outputs);
% %     wspeed_del(i,z)=Y;
%     wspeed1(i+1,z)=wspeed1(i,z)+wspeed_del1(i,z);
%     wspeed2(i+1,z)=wspeed2(i,z)+wspeed_del2(i,z);
%     frequency(i+1,z)=frequency(i,z)+f_del(i,z);
%     Pei1(i+1,z)=Pei1(i,z)+Pei_del1(i,z);
%     Pei2(i+1,z)=Pei2(i,z)+Pei_del2(i,z);
%    frequency_time(:,z)=frequency1;
%    Pei_time1(:,z)=Pei(:,4);
%    Pei_time2(:,z)=Pei(:,8);
%   end
%    str = ['������...',num2str(z/n*100),'%'];
%    waitbar(z/n,wait_title,str);
% end
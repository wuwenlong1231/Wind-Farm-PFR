clear
clc
M1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.15����.xlsx','���1Ƶ���½�M');
C1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.15����.xlsx','���1Ƶ���½�C');
M2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.15����.xlsx','���2Ƶ���½�M');
C2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.15����.xlsx','���2Ƶ���½�C');

% C=C';
D=10;
%��������
windspeed=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','����','A2:B17');
wspeed1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','����','C2:C17');
wspeed2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\��������.xlsx','����','D2:D17');
wspeed1=wspeed1';
wspeed2=wspeed2';
H=299;
[n,m]=size(windspeed);%nΪ��������֤����
frequency(1,1:n)=50;
% wspeed1(1,1)=[0.817715131640888];
% windspeed(1,1)=[7.20368092159830];
% Kfi1(1,1)=1.3;
f=0.6;
[n,m]=size(windspeed);
wait_title = waitbar(0,'Please Wait'); 
Kfi1=zeros(n,1);
Kfi2=zeros(n,1);
for z=1:n
 %������ַ�����,
 [Kfi1(z,1)] =Koopman_erfenfa(M1,C1,wspeed1(1,z),windspeed(z,1),frequency(1,z),H,f,D);
 [Kfi2(z,1)] =Koopman_erfenfa(M2,C2,wspeed2(1,z),windspeed(z,2),frequency(1,z),H,f,D);
 for i=1:4
 Kfi(1,i)=Kfi1(z,1);
 Kfi(1,i+4)=Kfi2(z,1);
 end
 for i=1:4
     X2(1,i)=windspeed(z,1);
     X2(1,i+4)=windspeed(z,2);
 end
[wspeed,frequency1,Pe,Pei] = Windfarm_down(X2,Kfi);
wspeed_final(:,z)=wspeed(301,:);
 str = ['������...',num2str(z/n*100),'%'];
   waitbar(z/n,wait_title,str);
end
Kfi_Koop(:,1)=Kfi1(:,1);
Kfi_Koop(:,2)=Kfi2(:,1);


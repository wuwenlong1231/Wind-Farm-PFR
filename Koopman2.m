clear
clc
wspeed1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.25.xlsx','���1ת��');
wspeed2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.25.xlsx','���2ת��');
Kfi=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.25.xlsx','����´�ϵ��');
windspeed1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.25.xlsx','���1����');
windspeed2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.25.xlsx','���2����');
frequency=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.25.xlsx','Ƶ��');
H=299;%��Ҫѵ����M�ĸ���
D=100;%����ά��
for j=1:7
    t=0;
    y=1;
   C(:,j)=-2+4*rand(D,1);
%      C(:,j)=t:(y-t)/(D-1):y;
 end
[a,b]=size(wspeed2);
C=C';
for i=1:H+1
    for j=1:b
    windspeed1(i,:)=windspeed1(1,:);
    windspeed2(i,:)=windspeed2(1,:);
    Kf1(i,j)=Kfi(j,1);
    Kf2(i,j)=Kfi(j,2);
    end
end
for j=1:b%�˴�Ϊ��C�ķ���һ��
    for i=1:H
       input1(1,(j-1)*H+i)=wspeed1(i,j);%״̬������
       input1(2,(j-1)*H+i)=wspeed2(i,j);%״̬������
       input1(3,(j-1)*H+i)=frequency(i,j);%״̬������
       input1(4,(j-1)*H+i)=Kf1(i,j);%������
       input1(5,(j-1)*H+i)=Kf2(i,j);%������
       input1(6,(j-1)*H+i)=windspeed1(i,j);%������
       input1(7,(j-1)*H+i)=windspeed2(i,j);%������
       output1(1,(j-1)*H+i)=wspeed1(i+1,j);%״̬������
       output1(2,(j-1)*H+i)=wspeed2(i+1,j);%״̬������
       output1(3,(j-1)*H+i)=frequency(i+1,j);%״̬������
       output1(4,(j-1)*H+i)=Kf1(i+1,j);%������
       output1(5,(j-1)*H+i)=Kf2(i+1,j);%������       
       output1(6,(j-1)*H+i)=windspeed1(i+1,j);
       output1(7,(j-1)*H+i)=windspeed2(i+1,j);
    end
end
[inputn,inputs1]=mapminmax(input1,0,1);%�ɵ�-1��1
C1=mapminmax('reverse',C,inputs1);
C1=C1';
wait_title = waitbar(0,'Please Wait'); 
for i=1:H%ѵ��һ��M
       input2(1,:)=wspeed1(i,:);%״̬������
       input2(2,:)=wspeed2(i,:);%״̬������
       input2(3,:)=frequency(i,:);%״̬������
       input2(4,:)=Kf1(i,:);%������
       input2(5,:)=Kf2(i,:);%������
       input2(6,:)=windspeed1(i,:);%������
       input2(7,:)=windspeed2(i,:);%������
       output2(1,:)=wspeed1(i+1,:);%״̬������
       output2(2,:)=wspeed2(i+1,:);%״̬������
       output2(3,:)=frequency(i+1,:);%״̬������
       output2(4,:)=Kf1(i+1,:);%������
       output2(5,:)=Kf2(i+1,:);%������ 
       output2(6,:)=windspeed1(i+1,j);       
       output2(7,:)=windspeed2(i+1,j);
[M1((i-1)*(D+3)+1:i*(D+3),:)]=solveM1(input2(1,:),input2(2,:),input2(3,:),input2(4,:),input2(5,:),input2(6,:),input2(7,:),output2(1,:),output2(2,:),output2(3,:),output2(4,:),output2(5,:),output2(6,:),output2(7,:),C1,D);
 str = ['������...',num2str(i/H*100),'%'];
 waitbar(i/H,wait_title,str);
 end

%%
xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.16����.xlsx',M1,'�糡Ƶ���½�M');
xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.16����.xlsx',C1,'�糡Ƶ���½�C');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.15����.xlsx',M2,'���2Ƶ���½�M');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.15����.xlsx',C2,'���2Ƶ���½�C');

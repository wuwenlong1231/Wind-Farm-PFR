clear
clc
wspeed1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx','���1ת��');
wspeed2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx','���2ת��');
Kf1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx','���1�´�ϵ��');
Kf2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx','���2�´�ϵ��');
windspeed1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx','���1����');
windspeed2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx','���2����');
frequency=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx','Ƶ��');
% delta_wspeed1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx','���1ת�ٸı�');
% delta_wspeed2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx','���2ת�ٸı�');
% delta_Pei1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx','���1���ʸı�');
% delta_Pei2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx','���2���ʸı�');
% delta_f=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx','Ƶ�ʸı�');
H=299;%��Ҫѵ����M�ĸ���
D=10;%����ά��
for j=1:4
    t=0;
    y=1;
   C(:,j)=0.5+0.5*rand(D,1);
%      C(:,j)=t:(y-t)/(D-1):y;
 end
[a,b]=size(wspeed2);
C=C';
for j=1:b%�˴�Ϊ��C�ķ���һ��
    for i=1:H
       input1(1,(j-1)*H+i)=wspeed2(i,j);%״̬������
       input1(2,(j-1)*H+i)=frequency(i,j);
       input1()
       input1(3,(j-1)*H+i)=Kf2(i,j);%������
       input1(4,(j-1)*H+i)=windspeed2(i,j);
       output1(1,(j-1)*H+i)=wspeed2(i+1,j);%״̬�����
       output1(2,(j-1)*H+i)=frequency(i+1,j);
       output1(3,(j-1)*H+i)=Kf2(i+1,j);
       output1(4,(j-1)*H+i)=windspeed2(i+1,j);
    end
end
[inputn,inputs1]=mapminmax(input1,0,1);%�ɵ�-1��1
C1=mapminmax('reverse',C,inputs1);
C1=C1';
for j=1:b%�˴�Ϊ��C�ķ���һ��
    for i=1:H
       input2(1,(j-1)*H+i)=wspeed2(i,j);%״̬������
       input2(2,(j-1)*H+i)=frequency(i,j);
       input2(3,(j-1)*H+i)=Kf2(i,j);%������
       input2(4,(j-1)*H+i)=windspeed2(i,j);
       output2(1,(j-1)*H+i)=wspeed2(i+1,j);%״̬�����
       output2(2,(j-1)*H+i)=frequency(i+1,j);
       output2(3,(j-1)*H+i)=Kf2(i+1,j);
       output2(4,(j-1)*H+i)=windspeed2(i+1,j);
    end
end
[inputn,inputs2]=mapminmax(input2,0,1);%�ɵ�-1��1
C2=mapminmax('reverse',C,inputs2);
C2=C2';
wait_title = waitbar(0,'Please Wait'); 
for i=1:H%ѵ��һ��M
  input3(1,:)=wspeed1(i,:);
  input3(2,:)=frequency(i,:);
  input3(3,:)=Kf1(i,:);%������
  input3(4,:)=windspeed1(i,:);
  output3(1,:)=wspeed1(i+1,:);%״̬�����
  output3(2,:)=frequency(i+1,:);
  output3(3,:)=Kf1(i+1,:);
  output3(4,:)=windspeed1(i+1,:);
    input4(1,:)=wspeed2(i,:);
  input4(2,:)=frequency(i,:);
  input4(3,:)=Kf2(i,:);%������
  input4(4,:)=windspeed2(i,:);
  output4(1,:)=wspeed2(i+1,:);%״̬�����
  output4(2,:)=frequency(i+1,:);
  output4(3,:)=Kf2(i+1,:);
  output4(4,:)=windspeed2(i+1,:);
[M1((i-1)*(D+2)+1:i*(D+2),:)]=solveM1(input3(1,:),input3(2,:),input3(3,:),input3(4,:),output3(1,:),output3(2,:),output3(3,:),output3(4,:),C1,D);
[M2((i-1)*(D+2)+1:i*(D+2),:)]=solveM1(input4(1,:),input4(2,:),input4(3,:),input4(4,:),output4(1,:),output4(2,:),output4(3,:),output4(4,:),C1,D);

 str = ['������...',num2str(i/H*100),'%'];
 waitbar(i/H,wait_title,str);
 end

%%
xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.15����.xlsx',M1,'�糡Ƶ���½�M');
xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.15����.xlsx',C1,'�糡Ƶ���½�C');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.15����.xlsx',M2,'���2Ƶ���½�M');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Koopman����10.15����.xlsx',C2,'���2Ƶ���½�C');

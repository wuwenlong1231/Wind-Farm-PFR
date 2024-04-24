clear
clc
wspeed1=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx','风机1转速');
wspeed2=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx','风机2转速');
Kf1=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx','风机1下垂系数');
Kf2=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx','风机2下垂系数');
windspeed1=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx','风机1风速');
windspeed2=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx','风机2风速');
frequency=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx','频率');
% delta_wspeed1=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx','风机1转速改变');
% delta_wspeed2=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx','风机2转速改变');
% delta_Pei1=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx','风机1功率改变');
% delta_Pei2=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx','风机2功率改变');
% delta_f=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx','频率改变');
H=299;%需要训练的M的个数
D=10;%升高维度
for j=1:4
    t=0;
    y=1;
   C(:,j)=0.5+0.5*rand(D,1);
%      C(:,j)=t:(y-t)/(D-1):y;
 end
[a,b]=size(wspeed2);
C=C';
for j=1:b%此处为了C的反归一化
    for i=1:H
       input1(1,(j-1)*H+i)=wspeed2(i,j);%状态输入量
       input1(2,(j-1)*H+i)=frequency(i,j);
       input1()
       input1(3,(j-1)*H+i)=Kf2(i,j);%控制量
       input1(4,(j-1)*H+i)=windspeed2(i,j);
       output1(1,(j-1)*H+i)=wspeed2(i+1,j);%状态输出量
       output1(2,(j-1)*H+i)=frequency(i+1,j);
       output1(3,(j-1)*H+i)=Kf2(i+1,j);
       output1(4,(j-1)*H+i)=windspeed2(i+1,j);
    end
end
[inputn,inputs1]=mapminmax(input1,0,1);%可调-1，1
C1=mapminmax('reverse',C,inputs1);
C1=C1';
for j=1:b%此处为了C的反归一化
    for i=1:H
       input2(1,(j-1)*H+i)=wspeed2(i,j);%状态输入量
       input2(2,(j-1)*H+i)=frequency(i,j);
       input2(3,(j-1)*H+i)=Kf2(i,j);%控制量
       input2(4,(j-1)*H+i)=windspeed2(i,j);
       output2(1,(j-1)*H+i)=wspeed2(i+1,j);%状态输出量
       output2(2,(j-1)*H+i)=frequency(i+1,j);
       output2(3,(j-1)*H+i)=Kf2(i+1,j);
       output2(4,(j-1)*H+i)=windspeed2(i+1,j);
    end
end
[inputn,inputs2]=mapminmax(input2,0,1);%可调-1，1
C2=mapminmax('reverse',C,inputs2);
C2=C2';
wait_title = waitbar(0,'Please Wait'); 
for i=1:H%训练一串M
  input3(1,:)=wspeed1(i,:);
  input3(2,:)=frequency(i,:);
  input3(3,:)=Kf1(i,:);%控制量
  input3(4,:)=windspeed1(i,:);
  output3(1,:)=wspeed1(i+1,:);%状态输出量
  output3(2,:)=frequency(i+1,:);
  output3(3,:)=Kf1(i+1,:);
  output3(4,:)=windspeed1(i+1,:);
    input4(1,:)=wspeed2(i,:);
  input4(2,:)=frequency(i,:);
  input4(3,:)=Kf2(i,:);%控制量
  input4(4,:)=windspeed2(i,:);
  output4(1,:)=wspeed2(i+1,:);%状态输出量
  output4(2,:)=frequency(i+1,:);
  output4(3,:)=Kf2(i+1,:);
  output4(4,:)=windspeed2(i+1,:);
[M1((i-1)*(D+2)+1:i*(D+2),:)]=solveM1(input3(1,:),input3(2,:),input3(3,:),input3(4,:),output3(1,:),output3(2,:),output3(3,:),output3(4,:),C1,D);
[M2((i-1)*(D+2)+1:i*(D+2),:)]=solveM1(input4(1,:),input4(2,:),input4(3,:),input4(4,:),output4(1,:),output4(2,:),output4(3,:),output4(4,:),C1,D);

 str = ['运行中...',num2str(i/H*100),'%'];
 waitbar(i/H,wait_title,str);
 end

%%
xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\Koopman数据10.15更新.xlsx',M1,'风场频率下降M');
xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\Koopman数据10.15更新.xlsx',C1,'风场频率下降C');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\Koopman数据10.15更新.xlsx',M2,'风机2频率下降M');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\Koopman数据10.15更新.xlsx',C2,'风机2频率下降C');

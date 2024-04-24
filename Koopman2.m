clear
clc
wspeed1=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.25.xlsx','风机1转速');
wspeed2=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.25.xlsx','风机2转速');
Kfi=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.25.xlsx','风机下垂系数');
windspeed1=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.25.xlsx','风机1风速');
windspeed2=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.25.xlsx','风机2风速');
frequency=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.25.xlsx','频率');
H=299;%需要训练的M的个数
D=100;%升高维度
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
for j=1:b%此处为了C的反归一化
    for i=1:H
       input1(1,(j-1)*H+i)=wspeed1(i,j);%状态输入量
       input1(2,(j-1)*H+i)=wspeed2(i,j);%状态输入量
       input1(3,(j-1)*H+i)=frequency(i,j);%状态输入量
       input1(4,(j-1)*H+i)=Kf1(i,j);%控制量
       input1(5,(j-1)*H+i)=Kf2(i,j);%控制量
       input1(6,(j-1)*H+i)=windspeed1(i,j);%控制量
       input1(7,(j-1)*H+i)=windspeed2(i,j);%控制量
       output1(1,(j-1)*H+i)=wspeed1(i+1,j);%状态输入量
       output1(2,(j-1)*H+i)=wspeed2(i+1,j);%状态输入量
       output1(3,(j-1)*H+i)=frequency(i+1,j);%状态输入量
       output1(4,(j-1)*H+i)=Kf1(i+1,j);%控制量
       output1(5,(j-1)*H+i)=Kf2(i+1,j);%控制量       
       output1(6,(j-1)*H+i)=windspeed1(i+1,j);
       output1(7,(j-1)*H+i)=windspeed2(i+1,j);
    end
end
[inputn,inputs1]=mapminmax(input1,0,1);%可调-1，1
C1=mapminmax('reverse',C,inputs1);
C1=C1';
wait_title = waitbar(0,'Please Wait'); 
for i=1:H%训练一串M
       input2(1,:)=wspeed1(i,:);%状态输入量
       input2(2,:)=wspeed2(i,:);%状态输入量
       input2(3,:)=frequency(i,:);%状态输入量
       input2(4,:)=Kf1(i,:);%控制量
       input2(5,:)=Kf2(i,:);%控制量
       input2(6,:)=windspeed1(i,:);%控制量
       input2(7,:)=windspeed2(i,:);%控制量
       output2(1,:)=wspeed1(i+1,:);%状态输入量
       output2(2,:)=wspeed2(i+1,:);%状态输入量
       output2(3,:)=frequency(i+1,:);%状态输入量
       output2(4,:)=Kf1(i+1,:);%控制量
       output2(5,:)=Kf2(i+1,:);%控制量 
       output2(6,:)=windspeed1(i+1,j);       
       output2(7,:)=windspeed2(i+1,j);
[M1((i-1)*(D+3)+1:i*(D+3),:)]=solveM1(input2(1,:),input2(2,:),input2(3,:),input2(4,:),input2(5,:),input2(6,:),input2(7,:),output2(1,:),output2(2,:),output2(3,:),output2(4,:),output2(5,:),output2(6,:),output2(7,:),C1,D);
 str = ['运行中...',num2str(i/H*100),'%'];
 waitbar(i/H,wait_title,str);
 end

%%
xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\Koopman数据10.16更新.xlsx',M1,'风场频率下降M');
xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\Koopman数据10.16更新.xlsx',C1,'风场频率下降C');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\Koopman数据10.15更新.xlsx',M2,'风机2频率下降M');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\Koopman数据10.15更新.xlsx',C2,'风机2频率下降C');

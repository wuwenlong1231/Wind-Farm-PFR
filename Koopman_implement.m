clear

M=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\Koopman数据10.15更新.xlsx','风机1频率下降M');
C=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\Koopman数据10.15更新.xlsx','风机1频率下降C');
% C=C';
D=50;
%测试数据
windspeed=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\测试数据.xlsx','sheet1','A2:B17');
wspeed1=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\测试数据.xlsx','sheet1','C2:C17');
% wspeed2=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\测试数据.xlsx','sheet1','D2:D17');
wspeed1=wspeed1';

% Kf=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\测试数据.xlsx','sheet1','E2:E17');
Kfi1=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\测试数据.xlsx','下降风机1系数');
% Kfi2=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\测试数据.xlsx','上升风机2系数');
% Pei1=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\测试数据.xlsx','sheet1','G2:G17');
% Pei2=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\测试数据.xlsx','sheet1','H2:H17');
% Pei1=Pei1';
% Pei2=Pei2';
H=299;
[n,m]=size(windspeed);%n为多少种验证风速
frequency(1,1:n)=50;
% wait_title = waitbar(0,'Please Wait'); 
% load(['D:\本科期间各种材料\MATLAB材料\PES会议\10.13PES会议\频率下降归一化结构体\输入归一化.mat']);
% load(['D:\本科期间各种材料\MATLAB材料\PES会议\10.13PES会议\频率下降归一化结构体\输出归一化.mat']);
wspeed1(1,1)=[0.817715131640888];
windspeed(1,1)=[7.20368092159830];
Kfi1(1,1)=1.3;
for z=1:1%n
    X1(1,1)=wspeed1;%
    X1(2,1)=wspeed2;%
    X1(3,1)=frequency;%\
    X1(4,1)=Kf1;%
    X1(5,1)=Kf2;%
    X1(6,1)=windspeed1;%此处是使用SOE的Kfi数据进行训练的
    X1(7,1)=windspeed2;%
    %升维观测向量构建
    [r,t]=size(X1);
    for a=1:D
        for b=1:r%输入向量的维数
            f1(1,b)=(X1(b,1)-C(a,b))^2;
        end
      f2=sum(f1,2)^0.5;
     X2(a,1)=exp(-(1*f2)^2);
    end
    X=[X1(1:3,:);X2;X1(4:7,:)];
    [a,b]=size(X);
  for i=1:H%线性模型滚动预测
    M1=M((i-1)*(D+2)+1:i*(D+2),:);
    Y=M1*X;%此时Y为归一化数值
    wspeed3(i,1)=Y(1,1);%输出变量
    wspeed4(i,1)=Y(2,1);
    frequency1(i,1)=Y(2,1);
    X(1:a-4,1)=Y;%更新输入变量状态
  end 
  disp(wspeed3(H,:));
  disp(wspeed4(H,:));
end
figure(1)
plot(frequency1);
figure(2)
plot(wspeed3);

function [ output_args ] = Koopman_wspeed(Kfi)
M=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\Koopman数据.xlsx','频率上升M');
C=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\Koopman数据.xlsx','频率上升C转置');
C=C';
D=100;
%测试数据
windspeed=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\风速.xlsx','sheet1','A2:B17');
wspeed=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\风速.xlsx','sheet1','C2:C17');
wspeed=wspeed';
Kf=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\风速.xlsx','sheet1','E2:E17');
% Kfi=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\风速.xlsx','上升风机1系数');
H=300;
[n,m]=size(windspeed);
wait_title = waitbar(0,'Please Wait'); 

for z=1:n
       for j=1:4
        X2(1,j)=windspeed(z,1);
        X2(1,j+4)=windspeed(z,2);
       end
      [wspeed2,frequency,Pe,Pei,Pe2,SOE,Pm]=Windfarm_up(X2,Kf(z,1));
  for i=1:H
     load(['D:\本科期间各种材料\MATLAB材料\PES会议\10.6PES会议matlab\频率上升归一化结构体\输入归一化',num2str(i),'.mat']);
     load(['D:\本科期间各种材料\MATLAB材料\PES会议\10.6PES会议matlab\频率上升归一化结构体\输出归一化',num2str(i),'.mat']);
    M1=M(i,:);
    C1=C(:,(i-1)*4+1:4*i);
    X1(1,1)=wspeed(i,z);%
    X1(2,1)=Kfi(i,z);%
    X1(3,1)=windspeed(z,1);%?
    X1(4,1)=frequency(i,1);%?
    X1n=mapminmax('apply',X1,inputs);
    for a=1:D
        for b=1:4
%             f1(1,b)=(X1n(b,1)-C1(a,b))^2;
            f1(1,b)=(X1n(b,1)-C1(a,b))^2;
        end
         f2=sum(f1,2)^0.5;
     X2n(a,1)=f2*log(f2);
    end
%     X=[X1n;X2n];
    X=[X1n;X2n];
    Y=M1*X;
    wspeed_del(i,z)=mapminmax('reverse',Y,outputs);
%     wspeed_del(i,z)=Y;
    wspeed(i+1,z)=wspeed(i,z)+wspeed_del(i,z);
    
  end
   str = ['运行中...',num2str(z/n*100),'%'];
   waitbar(z/n,wait_title,str);
end
 wspeed1(1,:)=wspeed(H+1,:);


end


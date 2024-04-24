clear
clc
%%训练集设置
n=20;
M=301;
for i=1:4%7,11的范围
    for j=1:4
     w=(i+6)+0.25*j*rand(n,2);
     windspeed((i-1)*4*n+(j-1)*n+1:(i-1)*4*n+j*n,1:2)=w(1:n,1:2);
    end
end
% windspeed=xlsread('D:\本科期间各种材料\近期论文材料\考虑惯性与下垂系数\数据.xlsx','更新数据','C3:D87');
[a,b]=size(windspeed);
windspeed(1,1)=7;
windspeed(a,1)=11;
f1=0.63;%转速
wait_title = waitbar(0,'Please Wait'); 
for i=1:a
   [Kf(i,1)]=Kf_w(windspeed(i,:),f1);
   for H=1:4
   windspeed1(1,H)=windspeed(i,1);
   windspeed1(1,H+4)=windspeed(i,2);
   end%风机风速数据
  m=2;%Kf数量
    for j=1:m
            Kf1(j,1)=j*Kf(i,1)/m;
            [wspeed,frequency,Pe,Pei,Pe2,SOE,Pm,delta_wspeed,Kfi,delta_f,delta_Pei] =Windfarm_down(windspeed1(1,:),Kf1(j,1));
%             wspeed1((i-1)*m+j,1)=wspeed(3001,4);%输出变量
%             wspeed1((i-1)*m+j,2)=wspeed(3001,8);
%             Kf2((i-1)*m+j,1)=Kf1(j,1);
%             windspeed2((i-1)*m+j,:)=windspeed(i,:);
%              A=(i-1)*m*M+(j-1)*M+1;
%              B=(i-1)*m*M+j*M;
            wspeed1(1,(i-1)*m+j)=wspeed(1,4);%输出变量
            wspeed1(2,(i-1)*m+j)=wspeed(101,4);%输出变量
            wspeed1(3,(i-1)*m+j)=wspeed(201,4);%输出变量
            wspeed1(4,(i-1)*m+j)=wspeed(299,4);%输出变量
            wspeed2(1,(i-1)*m+j)=wspeed(2,4);%输出变量
            wspeed2(2,(i-1)*m+j)=wspeed(102,4);%输出变量
            wspeed2(3,(i-1)*m+j)=wspeed(202,4);%输出变量
            wspeed2(4,(i-1)*m+j)=wspeed(300,4);%输出变量
%             wspeed2(:,(i-1)*m+j)=wspeed(:,8);
               Kfi1(1,(i-1)*m+j)=Kfi(1,4);
               Kfi1(2,(i-1)*m+j)=Kfi(101,4);
               Kfi1(3,(i-1)*m+j)=Kfi(201,4);
               Kfi1(4,(i-1)*m+j)=Kfi(299,4);
               Kfi2(1,(i-1)*m+j)=Kfi(2,4);
               Kfi2(2,(i-1)*m+j)=Kfi(102,4);
               Kfi2(3,(i-1)*m+j)=Kfi(202,4);
               Kfi2(4,(i-1)*m+j)=Kfi(300,4);
%             Kfi2(:,(i-1)*m+j)=Kfi(:,8);
%             Kf2(1:M,(i-1)*m+j)=Kf1(j,1);
            windspeed2(1:4,(i-1)*m+j)=windspeed(i,1);
%             windspeed3(1:M,(i-1)*m+j)=windspeed(i,2);
%             frequency1(1:M,(i-1)*m+j)=frequency(:,1);
%             delta_wspeed1(:,(i-1)*m+j)=delta_wspeed(:,4);
%             delta_wspeed2(:,(i-1)*m+j)=delta_wspeed(:,8);
%             delta_Pei1(:,(i-1)*m+j)=delta_Pei(:,1);
%             delta_Pei2(:,(i-1)*m+j)=delta_Pei(:,2);
%             delta_f1(:,(i-1)*m+j)=delta_f(:,1);

    end
    str = ['运行中...',num2str(i/a*100),'%'];
    waitbar(i/a,wait_title,str); 
end 
delete(wait_title); %删除进度条
% %%
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.15.xlsx',wspeed1,'风机1输入转速');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.15.xlsx',Kfi1,'风机1输入下垂系数');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.15.xlsx',wspeed2,'风机1输出转速');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.15.xlsx',Kfi2,'风机1输出下垂系数');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.15.xlsx',windspeed2,'风机1风速');

% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx',Kfi1,'风机1下垂系数');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx',Kfi2,'风机2下垂系数');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx',Kf2,'下垂系数');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx',windspeed2,'风机1风速');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx',windspeed3,'风机2风速');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx',frequency1,'频率');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx',delta_wspeed1,'风机1转速改变');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx',delta_wspeed2,'风机2转速改变');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx',delta_f1,'频率改变');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx',delta_Pei1,'风机1功率改变');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.9.xlsx',delta_Pei2,'风机2功率改变');
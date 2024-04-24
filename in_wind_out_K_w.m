clc
clear
m=1;%每种风速下的转速下垂数量
% windspeed=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\测试结果.xlsx','频率下降精确','A2:B13');
windspeed=xlsread('D:\本科期间各种材料\近期论文材料\考虑惯性与下垂系数\三维图.xlsx','Koopman','A3:B29');
[a,b]=size(windspeed);
wmax=1.3;
wmin=0.7;
for i=1:a
   for j=1:10
    X2(i,j)=windspeed(i,1);
    X2(i,j+10)=windspeed(i,2);
    end
 for z=1:m
%     f1=(wspeed1-wmin)/m*(z-1)+wmin;
%     f2=(wspeed2-wmin)/m*(z-1)+wmin; %频率下降
%     f1=wmax-(wmax-wspeed1)/m*(z-1);
%     f2=wmax-(wmax-wspeed2)/m*(z-1); %频率上升
    f1=wmax;
    f2=wmax;
    j=1;
    Kfi2(z,j)=0;
    I=1;
    [Kfi1(z,j)]=Time_erfenfa1(windspeed(i,:),f1,I,Kfi2(z,j));
    while(1)
     I=0;
    [Kfi2(z,j+1)]=Time_erfenfa1(windspeed(i,:),f2,I,Kfi1(z,j));
     I=1;
    [Kfi1(z,j+1)]=Time_erfenfa1(windspeed(i,:),f1,I,Kfi2(z,j+1));
     if abs(Kfi1(z,j+1)-Kfi1(z,j))<=0.01&&abs(Kfi2(z,j+1)-Kfi2(z,j))<=0.01%收敛
     break
     end
      j=j+1;
    end
    Kfi((i-1)*m+z,1)=Kfi1(z,j+1);
    Kfi((i-1)*m+z,2)=Kfi2(z,j+1);
    for k=1:10
    Kfi_N((i-1)*m+z,k)=Kfi((i-1)*m+z,1);
    Kfi_N((i-1)*m+z,k+10)=Kfi((i-1)*m+z,2); 
    end
 [wspeed,frequency,Pe,Pei] =Windfarm_up_new(X2(i,:),Kfi_N((i-1)*m+z,:));
  wspeed3(1,(i-1)*m+z)=wspeed(1,1);%输出变量
  wspeed3(2,(i-1)*m+z)=wspeed(1,11);%输出变量
%   frequency1(:,(i-1)*m+z)=frequency(:,1);
%   windspeed1(1,(i-1)*m+z)=windspeed(i,1);
%   windspeed2(1,(i-1)*m+z)=windspeed(i,2);
%   f3(1,(i-1)*m+z)=f1;
%   f3(2,(i-1)*m+z)=f2;
 end
end
%%
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据对照组.xlsx',frequency1,'频率');



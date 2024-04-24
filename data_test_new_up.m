clear
clc
%%训练集设置
n=50;
M=301;
for i=1:4%7,11的范围
    for j=1:4
     w=(i+6)+0.25*j*rand(n,2);
     windspeed((i-1)*4*n+(j-1)*n+1:(i-1)*4*n+j*n,1:2)=w(1:n,1:2);
    end
end

[a,b]=size(windspeed);
wmin=[0.73];%转速
% wmin1=[0.73,0.75,0.77];
wmax=1.27;
m=4;%每种风速下的转速下垂数量
h=2;
wspeed0=zeros(1,20);
R=55.5;
belta=0;
wait_title = waitbar(0,'Please Wait'); 
for i=1:a %%800次循环？
    for j=1:10
    X2(i,j)=windspeed(i,1);
    X2(i,j+10)=windspeed(i,2);
    end
    [wspeed(1,:),Pm(1,:)]=Cpmax(wspeed0,X2(i,:),R,belta);%为了给出转速初值
    wspeed1(1,1)=wspeed(1,1);
    wspeed1(1,2)=wspeed(1,11);
    wspeed_min=min(wspeed1);
 for z=1:h
%     f1=wmin+(wspeed_min-wmin)*(z-1)/m;
%     f2=wmin+(wspeed_min-wmin)*(z-1)/m;
    f1=wmax;
    f2=wmax;
    j=1;
    Kfi2(z,j)=0;
    I=1;
    [Kfi1(z,j)]=Time_erfenfa1_up(windspeed(i,:),f1,I,Kfi2(z,j));%风机1的系数
    while(1)
     I=0;
    [Kfi2(z,j+1)]=Time_erfenfa1_up(windspeed(i,:),f2,I,Kfi1(z,j));%风机2的系数
     I=1;
    [Kfi1(z,j+1)]=Time_erfenfa1_up(windspeed(i,:),f1,I,Kfi2(z,j+1));
     if abs(Kfi1(z,j+1)-Kfi1(z,j))<=0.01&&abs(Kfi2(z,j+1)-Kfi2(z,j))<=0.01%收敛
     break
     end
      j=j+1;
    end
    Kfi((i-1)*h+z,1)=Kfi1(z,j+1);
    Kfi((i-1)*h+z,2)=Kfi2(z,j+1);
    for k=1:10
    Kfi_N((i-1)*h+z,k)=Kfi((i-1)*h+z,1);
    Kfi_N((i-1)*h+z,k+10)=Kfi((i-1)*h+z,2); 
    end
 [wspeed,frequency,Pe,Pei] = Windfarm_up_new(X2(i,:),Kfi_N((i-1)*h+z,:));
  wspeed3(:,(i-1)*h+z)=wspeed(:,1);%输出变量
  wspeed4(:,(i-1)*h+z)=wspeed(:,11);%输出变量
  frequency1(:,(i-1)*h+z)=frequency(:,1);
  windspeed1(1,(i-1)*h+z)=windspeed(i,1);
  windspeed2(1,(i-1)*h+z)=windspeed(i,2);
  f3(1,(i-1)*h+z)=f1;
  f3(2,(i-1)*h+z)=f2;
  str = ['运行中...',num2str(i/a*100),'%'];
 waitbar(i/a,wait_title,str);
 end
end
 delete(wait_title);
%%
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.26六修.xlsx',wspeed3,'风机1转速');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.26六修.xlsx',wspeed4,'风机2转速');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.26六修.xlsx',windspeed1,'风机1风速');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.26六修.xlsx',windspeed2,'风机2风速');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.26六修.xlsx',Kfi,'风机下垂系数');
% xlswrite('D:\本科期间各种材料\近期论文材料\PES会议材料\频率下降数据10.26六修.xlsx',frequency1,'频率');

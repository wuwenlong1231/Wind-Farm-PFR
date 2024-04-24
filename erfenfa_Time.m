clc
clear
windspeed=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\测试数据.xlsx','测试','A2:B13');
% windspeed=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\测试数据.xlsx','三维图','A3:B15');
% windspeed=xlsread('D:\本科期间各种材料\近期论文材料\PES会议材料\测试结果.xlsx','三维图','W3:X27');
[n,m]=size(windspeed);
f=1.3;

for z=1:n
    j=1;
    Kfi2(z,j)=0;
    I=1;
    [Kfi1(z,j)] = Time_erfenfa1(windspeed(z,:),f,I,Kfi2(z,j));
    while(1)
     I=0;
    [Kfi2(z,j+1)] = Time_erfenfa1(windspeed(z,:),f,I,Kfi1(z,j));
     I=1;
    [Kfi1(z,j+1)] = Time_erfenfa1(windspeed(z,:),f,I,Kfi2(z,j+1));
     if (Kfi1(1,j+1)-Kfi1(1,j))<=0.01&&(Kfi2(1,j+1)-Kfi2(1,j))<=0.01
     break
     end
      j=j+1;
    end
    Kf(z,1)=Kfi1(z,j+1);
    Kf(z,2)=Kfi2(z,j+1);

end

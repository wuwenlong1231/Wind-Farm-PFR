function [wspeed,frequency,Pe,Pei] = Windfarm_down_new(X2,Kfi)
%频率下降时，风电场一次调频过程
N=20;%风机数量
for i=1:N
    wspeed0(1,i)=1;
end
% PL=1800000;%15MW
% M=3000%循环次数
% H=3000;;%系统惯量 
% K1=35;%火电下垂25
% K2=10;%火电惯性30
PL=2400000000;%15MW/100MW
M=300;%循环次数
H=800000;%系统惯量 
K1=25000;%火电下垂35
K2=30;%火电惯性30
a=0;
R=55.5;
S=pi*R*R;
T=0.1;
for i=1:N
  J1(i,1)=40329760;%15329760 
end
windspeed=zeros(M,N);

for i=1:M/100
     for i1=1:100
         for j=1:N
     windspeed((i-1)*100+i1,j)=X2(1,j);    
         end
     end
end
%  windspeed=X2;
wspeed=zeros(M+1,N);
Pm=zeros(M+1,N);
Pe=zeros(M+1,1);
k=zeros(M+1,N);
Cp=zeros(M+1,N);
frequency=zeros(M+1,1);
SOE=zeros(M,N);
Pei=zeros(M+1,N);
Pe1=zeros(M,1);
B=zeros(M,1);
Pef=zeros(M,1);
 [wspeed(1,:),Pm(1,:)]=Cpmax(wspeed0,windspeed,R,a);
frequency(1,1)=50;
for i=1:M
     for j=1:N%cp1函数+转速
    k(i,j)=wspeed(i,j)/windspeed(i,j)*R;
%    Cp(i,j)=0.22*(116/k(i,j)-0.4*a-5)*exp(-12.5/k(i,j));
%     Cp(i,j)=-0.419+0.218*(k(i,j))-0.012*(k(i,j))^2-0.0001336*(k(i,j))^3+0.00001152*(k(i,j))^4;
%      Cp(i,j)=0.5*(116*(1/(k(i,j)+0.08*a)-0.035/(a^3+1))-0.4*a-5)*exp(-21*(1/(k(i,j)+0.08*a)-0.035/(a^3+1)));
    Cp(i,j)=0.22*(116*(1/(k(i,j)+0.08*a)-0.035/(a^3+1))-0.4*a-5)*exp(-12.5*(1/(k(i,j)+0.08*a)-0.035/(a^3+1)));
    Pm(i,j)=0.5*1.3*S*Cp(i,j)*windspeed(i,j)^3;%由转速和风速决定的
     end
    %风场
     Pef(i,1)=K1*(frequency(1,1)-frequency(i,1))*1000000;%火电厂增加出力（下垂）
     f_del(i,1)=(frequency(1,1)-frequency(i,1))*1000000;
     Pe1(i,1)=sum(Kfi,2)*(frequency(1,1)-frequency(i,1))*1000000;%风场下垂特性
     Pe(i,1)=Pe1(i,1)+sum(Pm(1,:));%风场出力
     frequency(i+1,1)=frequency(i,1)+T*50/(2*H)*(Pe1(i,1)+Pef(i,1)-PL)/1000000;%频率
%      风机
           for j=1:N
            SOE(i,j)=(wspeed(i,j)^2-0.7^2)/(1.3^2-0.7^2); 
           end
    for j=1:N
%    SOE1(i,j)=SOE(i,j)/sum(SOE(i,:));
%    Kfi(i,j)=Kf*SOE1(i,j);
%    Pei(i,j)=(Pe(i,1)-sum(Pm(i,:)))*SOE1(i,j)+Pm(i,j);%风机功率
    Pei(i,j)=Kfi(1,j)*f_del(i,1)+Pm(1,j);    
    delta_wspeed(i,j)=(Pm(i,j)-Pei(i,j))/(J1(j,1)*wspeed(i,j))*T;
    wspeed(i+1,j)=wspeed(i,j)+delta_wspeed(i,j);
    end
end
a=1;


            






function [frequency,Pei,Kfi] = roll_up(X2,Kf,I,wspeed,frequency)
N=8;
for i=1:N
    wspeed0(1,i)=1;
end
PL=-7500000;%-90-1MW,75-1.5MW
M=50;%滚动次数
H=3000;%系统惯量 
K1=50;%火电厂下垂系数
a=0;
R=55.5;%59.5 75
S=pi*R*R;
T=0.1;
frequency0=50;
for i=1:N
  J1(i,1)=15329760;%1.5MW15329760,2.5MW25xx
end
windspeed=zeros(1,N);

for j=1:N
     windspeed(1,j)=X2(1,j);    
end
% wspeed=zeros(M+1,N);
% Pm=zeros(M+1,N);
% Pe=zeros(M+1,1);
% k=zeros(M+1,N);
% Cp=zeros(M+1,N);
% frequency=zeros(M+1,1);
% SOE=zeros(M,N);
% Pei=zeros(M+1,N);
% Pe1=zeros(M,1);
% B=zeros(M,1);
% Pef=zeros(M,1);
% frequency(1,1)=50;
% Pe2=zeros(M+1,1);
% Pe3=zeros(M+1,1);
% Pe2(1,1)=0;
% Pe3(1,1)=0;
for i=1:M
     for j=1:N%cp1函数+转速
     k(i,j)=wspeed(i,j)/windspeed(1,j)*R;
     Cp(i,j)=0.22*(116*(1/(k(i,j)+0.08*a)-0.035/(a^3+1))-0.4*a-5)*exp(-12.5*(1/(k(i,j)+0.08*a)-0.035/(a^3+1)));
     Pm(i,j)=0.5*1.3*S*Cp(i,j)*windspeed(1,j)^3;%由转速和风速决定的
     end
    %风场
     Pef(i,1)=K1*(frequency0-frequency(i,1))*1000000;%火电厂增加出力
     Pe1(i,1)=Kf*(frequency0-frequency(i,1))*1000000;%风场下垂特性
     Pe(i,1)=Pe1(i,1)+sum(Pm(1,:));%风场出力
     frequency(i+1,1)=frequency(i,1)+T*50/(2*H)*(Pe1(i,1)+Pef(i,1)-PL)/1000000;%频率
%      风机
   
    for j=1:N
          SOE(i,j)=(1.3^2-wspeed(i,j)^2)/(1.3^2-0.6^2);
    end
    for j=1:N
%    Pei(i,j)=(Pe(i,1)-sum(Pm(i,:)))*SOE(i,j)/sum(SOE(i,:))+Pm(i,j);%风机功率
     Pei(i,j)=Pe1(i,1)*SOE(i,j)/sum(SOE(i,:))+Pm(1,j);
     SOE1(i,j)=SOE(i,j)/sum(SOE(i,:));
     Kfi(i,j)=Kf*SOE1(i,j);
     delta_wspeed(i,j)=(Pm(i,j)-Pei(i,j))/(J1(j,1)*wspeed(i,j))*T;
     wspeed(i+1,j)=wspeed(i,j)+delta_wspeed(i,j);
    end  

end
   
end




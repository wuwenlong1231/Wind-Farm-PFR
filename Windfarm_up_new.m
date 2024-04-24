function [wspeed,frequency,Pe,Pei,Pe2,SOE,Pm,delta_wspeed,Kfi,delta_f,Pe_delta] = Windfarm_up_new(X2,Kfi)
% Ƶ������ʱ����糡һ�ε�Ƶ����
N=20;
for i=1:N
    wspeed0(1,i)=1;
end
PL=-4000000000;%-90-1MW,75-1.5MW
M=300;%ѭ������
H=800000;%ϵͳ���� 
K1=25000;%��糧�´�ϵ��
a=0;
R=55.5;%59.5 75
S=pi*R*R;
T=0.1;
for i=1:N
  J1(i,1)=40329760; %1.5MW15329760,2.5MW25xx
end
windspeed=zeros(M,N);

for i=1:M/100
     for i1=1:100
         for j=1:N
     windspeed((i-1)*100+i1,j)=X2(1,j);    
         end
     end
end

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
Pe2=zeros(M+1,1);
Pe3=zeros(M+1,1);
Pe2(1,1)=0;
Pe3(1,1)=0;
for i=1:M
     for j=1:N%cp1����+ת��
    k(i,j)=wspeed(i,j)/windspeed(i,j)*R;
     Cp(i,j)=0.22*(116*(1/(k(i,j)+0.08*a)-0.035/(a^3+1))-0.4*a-5)*exp(-12.5*(1/(k(i,j)+0.08*a)-0.035/(a^3+1)));
    Pm(i,j)=0.5*1.3*S*Cp(i,j)*windspeed(i,j)^3;%��ת�ٺͷ��پ�����
     end
    %�糡
     Pef(i,1)=K1*(frequency(1,1)-frequency(i,1))*1000000;%��糧���ӳ���
     Pe1(i,1)=sum(Kfi,2)*(frequency(1,1)-frequency(i,1))*1000000;%�糡�´�����
     Pe(i,1)=Pe1(i,1)+sum(Pm(1,:));%�糡����
     f_del(i,1)=(frequency(1,1)-frequency(i,1))*1000000;
     delta_f(i,1)=T*50/(2*H)*(Pe1(i,1)+Pef(i,1)-PL)/1000000;
     frequency(i+1,1)=frequency(i,1)+delta_f(i,1);%Ƶ��
%      ���
   
    for j=1:N
          SOE(i,j)=(1.3^2-wspeed(i,j)^2)/(1.3^2-0.6^2);
    end
    for j=1:N
%    Pei(i,j)=(Pe(i,1)-sum(Pm(i,:)))*SOE(i,j)/sum(SOE(i,:))+Pm(i,j);%�������
     Pei(i,j)=Kfi(1,j)*f_del(i,1)+Pm(1,j);    
     delta_wspeed(i,j)=(Pm(i,j)-Pei(i,j))/(J1(j,1)*wspeed(i,j))*T;
     wspeed(i+1,j)=wspeed(i,j)+delta_wspeed(i,j);
    end  

end
  for i=1:M
Pe_delta(i,1)=Pei(i+1,4)-Pei(i,4);
Pe_delta(i,2)=Pei(i+1,8)-Pei(i,8);
  end
  a=1;
end




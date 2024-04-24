function [wspeed,Pei] = operate(Kfi,Pm,frequency)
%OPERATE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
PL=-7500000;%-90-1MW,75-1.5MW
M=300;%��������
H=3000;%ϵͳ���� 
K1=50;%��糧�´�ϵ��
a=0;
R=55.5;%59.5 75
S=pi*R*R;
T=0.1;
frequency0=50;
for j=1:N
     windspeed(1,j)=X2(1,j);    
end
 for i=1:M
     for j=1:N
     Pei(i,j)=Kfi(i,j)*(frequency0-frequency(i,1))*1000000+Pm(1,j);
     k(i,j)=wspeed(i,j)/windspeed(1,j)*R;
     Cp(i,j)=0.22*(116*(1/(k(i,j)+0.08*a)-0.035/(a^3+1))-0.4*a-5)*exp(-12.5*(1/(k(i,j)+0.08*a)-0.035/(a^3+1)));
     Pm(i,j)=0.5*1.3*S*Cp(i,j)*windspeed(i,j)^3;%��ת�ٺͷ��پ�����
     delta_wspeed(i,j)=(Pm(i,j)-Pei(i,j))/(J1(j,1)*wspeed(i,j))*T;
     wspeed(i+1,j)=wspeed(i,j)+delta_wspeed(i,j);
     end  

 end
end


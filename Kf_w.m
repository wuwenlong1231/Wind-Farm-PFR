function [Kf,Kfi,Pei0] = Kf_w(windspeed,f1)
%%
%  Kin=0;%����
%  windspeed=[7.25 7.43 7.62 7.81];%����
for i=1:4
windspeed1(1,i)=windspeed(1,1);
windspeed1(1,i+4)=windspeed(1,2);
end%�����������
 n=20;%ÿ�ַ�����ѭ������
%  M=3000;
%  f1=1.28;
 [Kf,Kfi,Pei0] = Time_erfenfa(windspeed,f1); %ѵ��ĩֵ
%[Kf_max] = Time_erfenfa(windspeed,f0,Kin1); %ʵ�����ֵ
%������ʱ��ģ���н��
end
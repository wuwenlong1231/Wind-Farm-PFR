function [output]=koopman_model_wspeed(M,C,wspeed1,wspeed2,frequency,Kf1,Kf2,windspeed1,windspeed2,H,f,D)%����
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   ��ʼ��������
    X1(1,1)=wspeed1;%
    X1(2,1)=wspeed2;%
    X1(3,1)=frequency;%\
    X1(4,1)=Kf1;%
    X1(5,1)=Kf2;%
    X1(6,1)=windspeed1;%�˴���ʹ��SOE��Kfi���ݽ���ѵ����
    X1(7,1)=windspeed2;%
    %��ά�۲���������
    [r,t]=size(X1);
    for a=1:D
        for b=1:r%����������ά��
            f1(1,b)=(X1(b,1)-C(a,b))^2;
        end
      f2=sum(f1,2)^0.5;
     X2(a,1)=exp(-(1*f2)^2);
    end
    X=[X1(1:3,:);X2;X1(4:7,:)];
    [a,b]=size(X);
  for i=1:H%����ģ�͹���Ԥ��
    M1=M((i-1)*(D+2)+1:i*(D+2),:);
    Y=M1*X;%��ʱYΪ��һ����ֵ
    wspeed3(i,1)=Y(1,1);%�������
    wspeed4(i,1)=Y(2,1);
    frequency1(i,1)=Y(2,1);
    X(1:a-4,1)=Y;%�����������״̬
  end 
  output=f-wspeed3(H,1);
end


function[Kfi] = Koopman_erfenfa(M,C,wspeed,windspeed,frequency,H,f,D)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
eps=1e-10;%���ַ���������С
delta=1e-10;%�뼫��ת�ٲ�ֵ
a=0;b=10;%4.4 14f�½�k=3.3910  4.8292 6.3056 7.7354 9.1449 10.5571 11.4139 12.8693 14.3712
% 38.98 3.25f����K=30.5443 25.8795 20.7622 16.0287 11.8084  8.1509 6.2242  3.4261 1.0583
[fa]=koopman_model_wspeed(M,C,wspeed,a,windspeed,frequency,H,f,D);%ѭ�����ٴΣ��������ת��
[fb]=koopman_model_wspeed(M,C,wspeed,b,windspeed,frequency,H,f,D);
n=0;%��ʱ��ʼ
i=1;
while(1)
    c(1,i)=(a+b)/2;
    [fc(1,i)]=koopman_model_wspeed(M,C,wspeed,c(1,i),windspeed,frequency,H,f,D);
%     [fc(1,i),wspeed]=koopman_model_wspeed(c(1,i),Kin,windspeed2,f2,M,C,D,inputs,outputs);%ת��-0.7
    if(abs(fc(1,i))<delta)
        break
    end
   if fa*fc(1,i)<0
        b=c(1,i);fb=fc(1,i);%ת��-0.7
   else 
        a=c(1,i); fa=fc(1,i);
        %ѡ��������
    end
    if((b-a)<eps)
        break
    end
     if(fa*fb>0)%������
         disp(['Kfi is worse']);
        break%����
    end
    i=i+1;
    n=n+1;%n�ǵ�������
   
end
Kfi=c(1,i);


end


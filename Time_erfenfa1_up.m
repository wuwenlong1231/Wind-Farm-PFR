function [Kfi_out] = Time_erfenfa1(windspeed,f,I,Kfi)
for i=1:10
X2(1,i)=windspeed(1,1);
X2(1,i+10)=windspeed(1,2);
end
[e,h]=size(X2);
eps=1e-10;%���ַ���������С
delta=1e-10;%�뼫��ת�ٲ�ֵ
a=0;b=100;%4.4 14f�½�k=3.3910  4.8292 6.3056 7.7354 9.1449 10.5571 11.4139 12.8693 14.3712
% 38.98 3.25f����K=30.5443 25.8795 20.7622 16.0287 11.8084  8.1509 6.2242  3.4261 1.0583
if I==1%��һ̨���
[fa]=Time_modelup(a,Kfi,X2,f,I);
[fb]=Time_modelup(b,Kfi,X2,f,I);%ת��-0.7 
n=0;%��ʱ��ʼ
i=1;
while(1)
   
    c(1,i)=(a+b)/2;
    [fc(1,i)]=Time_modelup(c(1,i),Kfi,X2,f,I);%ת��-0.7
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
     if(fa*fb>0)
         print('worse');
        break
    end
    i=i+1;
    n=n+1;%n�ǵ�������
    
end
Kfi_out=c(1,i);
elseif I==0
    [fa]=Time_modelup(Kfi,a,X2,f,I);[fb]=Time_modelup(Kfi,b,X2,f,I);%ת��-0.7 
n=0;%��ʱ��ʼ
i=1;
while(1)
   
    c(1,i)=(a+b)/2;
    [fc(1,i)]=Time_modelup(Kfi,c(1,i),X2,f,I);%ת��-0.7
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
     if(fa*fb>0)
        break
    end
    i=i+1;
    n=n+1;%n�ǵ�������
    
end
end
Kfi_out=c(1,i);
end


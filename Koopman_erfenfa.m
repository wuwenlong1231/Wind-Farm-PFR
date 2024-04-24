function[Kfi] = Koopman_erfenfa(M,C,wspeed,windspeed,frequency,H,f,D)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
eps=1e-10;%二分法最后区间大小
delta=1e-10;%与极限转速差值
a=0;b=10;%4.4 14f下降k=3.3910  4.8292 6.3056 7.7354 9.1449 10.5571 11.4139 12.8693 14.3712
% 38.98 3.25f上升K=30.5443 25.8795 20.7622 16.0287 11.8084  8.1509 6.2242  3.4261 1.0583
[fa]=koopman_model_wspeed(M,C,wspeed,a,windspeed,frequency,H,f,D);%循环三百次，输出最后的转速
[fb]=koopman_model_wspeed(M,C,wspeed,b,windspeed,frequency,H,f,D);
n=0;%计时开始
i=1;
while(1)
    c(1,i)=(a+b)/2;
    [fc(1,i)]=koopman_model_wspeed(M,C,wspeed,c(1,i),windspeed,frequency,H,f,D);
%     [fc(1,i),wspeed]=koopman_model_wspeed(c(1,i),Kin,windspeed2,f2,M,C,D,inputs,outputs);%转速-0.7
    if(abs(fc(1,i))<delta)
        break
    end
   if fa*fc(1,i)<0
        b=c(1,i);fb=fc(1,i);%转速-0.7
   else 
        a=c(1,i); fa=fc(1,i);
        %选择了这里
    end
    if((b-a)<eps)
        break
    end
     if(fa*fb>0)%不单调
         disp(['Kfi is worse']);
        break%修正
    end
    i=i+1;
    n=n+1;%n是迭代次数
   
end
Kfi=c(1,i);


end


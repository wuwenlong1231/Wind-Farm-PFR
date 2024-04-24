function[M]=solveM1(wspeed1,wspeed2,frequency1,Kf1,Kf2,windspeed1,windspeed2,wspeed3,wspeed4,frequency2,Kf3,Kf4,windspeed3,windspeed4,C,D)
[m,n]=size(wspeed1);
% ‰»Î±‰¡øx
for j=1:n
    X1(1,j)=wspeed1(1,j);
    X1(2,j)=wspeed2(1,j);
    X1(3,j)=frequency1(1,j);
    X1(4,j)=Kf1(1,j);
    X1(5,j)=Kf2(1,j);
    X1(6,j)=windspeed1(1,j);
    X1(7,j)=windspeed2(1,j);
end
[a,b]=size(X1);
for i=1:D
 for j=1:n
     for g=1:a
         f1(1,g)=(X1(g,j)-C(i,g))^2;
     end
     f2=sum(f1,2)^0.5;
%      X2(i,j)=f2*log(f2);
%       X2(i,j)=1/(1+(1*f2)^2)^0.5;
X2(i,j)=exp(-(1*f2)^2);
% X2(i,j)=f2^2;
     f1=0;
 end
end
X=[X1(1:2,:);X2;X1(3:4,:)];
for j=1:n
    Y1(1,j)=wspeed3(1,j);
    Y1(2,j)=wspeed4(1,j);
    Y1(3,j)=frequency2(1,j);
    Y1(4,j)=Kf3(1,j);
    Y1(5,j)=Kf4(1,j);
    Y1(6,j)=windspeed3(1,j);
    Y1(7,j)=windspeed4(1,j);
end
f1=0;
for i=1:D
 for j=1:n
     for g=1:a
         f1(1,g)=(Y1(g,j)-C(i,g))^2;
     end
     f2=sum(f1,2)^0.5;
%      Y2(i,j)=f2*log(f2);
%     Y2(i,j)=1+(0.5*f2)^2;
      Y2(i,j)=exp(-(1*f2)^2);
%   Y2(i,j)=1/(1+(1*f2)^2)^0.5;
%      Y2(i,j)=f2^2;
     f1=0;
 end
end
  X=[X1(1:3,:);X2;X1(4:7,:)];
  Y=[Y1(1:3,:);Y2];
 H1=Y*X';
 H2=pinv(X*X');
 M=H1*H2;
end
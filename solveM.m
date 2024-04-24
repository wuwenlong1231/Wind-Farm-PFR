function[M]=solveM(wspeed3,frequency1,Kf3,windspeed3,wspeed4,frequency2,C,D)
[m,n]=size(wspeed3);
X1=zeros(4,n);
% ‰»Î±‰¡øx
for j=1:n
    X1(1,j)=wspeed3(1,j);
    X1(2,j)=frequency1(1,j);
    X1(3,j)=Kf3(1,j);
    X1(4,j)=windspeed3(1,j);
    X2(1,j)=wspeed3(1,j)^2;
    X2(2,j)=wspeed3(1,j)*windspeed3(1,j);
%     X2(3,j)=wspeed3(1,j)/windspeed3(1,j);
end
for j=1:n
    Y1(1,j)=wspeed4(1,j);
    Y1(2,j)=frequency2(1,j);
    Y2(1,j)=wspeed4(1,j)^2;
    Y2(2,j)=wspeed4(1,j)*windspeed3(1,j);
%     Y2(3,j)=wspeed4(1,j)/windspeed3(1,j);
end
  X=[X1(1:2,:);X2;X1(3:4,:)];
  Y=[Y1;Y2];
 H1=Y*X';
 H2=pinv(X*X');
 M=H1*H2;
end
clear
clc
n1=10;
for i=1:2%7,11�ķ�Χ
    for j=1:4
     w=(i+6)+0.25*j*rand(n1,2);
     windspeed1((i-1)*4*n1+(j-1)*n1+1:(i-1)*4*n1+j*n1,1:2)=w(1:n1,1:2);
    end
end
n2=20;
for i=1:2%7,11�ķ�Χ
    for j=1:4
     w=(i+8)+0.25*j*rand(n2,2);
     windspeed2((i-1)*4*n2+(j-1)*n2+1:(i-1)*4*n2+j*n2,1:2)=w(1:n2,1:2);
    end
end
wind=[windspeed1;windspeed2];
xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\10.26�½���������.xlsx',wind,'����');

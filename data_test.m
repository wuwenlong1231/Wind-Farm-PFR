clear
clc
%%ѵ��������
n=20;
M=301;
for i=1:4%7,11�ķ�Χ
    for j=1:4
     w=(i+6)+0.25*j*rand(n,2);
     windspeed((i-1)*4*n+(j-1)*n+1:(i-1)*4*n+j*n,1:2)=w(1:n,1:2);
    end
end
% windspeed=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\���ǹ������´�ϵ��\����.xlsx','��������','C3:D87');
[a,b]=size(windspeed);
windspeed(1,1)=7;
windspeed(a,1)=11;
f1=0.63;%ת��
wait_title = waitbar(0,'Please Wait'); 
for i=1:a
   [Kf(i,1)]=Kf_w(windspeed(i,:),f1);
   for H=1:4
   windspeed1(1,H)=windspeed(i,1);
   windspeed1(1,H+4)=windspeed(i,2);
   end%�����������
  m=2;%Kf����
    for j=1:m
            Kf1(j,1)=j*Kf(i,1)/m;
            [wspeed,frequency,Pe,Pei,Pe2,SOE,Pm,delta_wspeed,Kfi,delta_f,delta_Pei] =Windfarm_down(windspeed1(1,:),Kf1(j,1));
%             wspeed1((i-1)*m+j,1)=wspeed(3001,4);%�������
%             wspeed1((i-1)*m+j,2)=wspeed(3001,8);
%             Kf2((i-1)*m+j,1)=Kf1(j,1);
%             windspeed2((i-1)*m+j,:)=windspeed(i,:);
%              A=(i-1)*m*M+(j-1)*M+1;
%              B=(i-1)*m*M+j*M;
            wspeed1(1,(i-1)*m+j)=wspeed(1,4);%�������
            wspeed1(2,(i-1)*m+j)=wspeed(101,4);%�������
            wspeed1(3,(i-1)*m+j)=wspeed(201,4);%�������
            wspeed1(4,(i-1)*m+j)=wspeed(299,4);%�������
            wspeed2(1,(i-1)*m+j)=wspeed(2,4);%�������
            wspeed2(2,(i-1)*m+j)=wspeed(102,4);%�������
            wspeed2(3,(i-1)*m+j)=wspeed(202,4);%�������
            wspeed2(4,(i-1)*m+j)=wspeed(300,4);%�������
%             wspeed2(:,(i-1)*m+j)=wspeed(:,8);
               Kfi1(1,(i-1)*m+j)=Kfi(1,4);
               Kfi1(2,(i-1)*m+j)=Kfi(101,4);
               Kfi1(3,(i-1)*m+j)=Kfi(201,4);
               Kfi1(4,(i-1)*m+j)=Kfi(299,4);
               Kfi2(1,(i-1)*m+j)=Kfi(2,4);
               Kfi2(2,(i-1)*m+j)=Kfi(102,4);
               Kfi2(3,(i-1)*m+j)=Kfi(202,4);
               Kfi2(4,(i-1)*m+j)=Kfi(300,4);
%             Kfi2(:,(i-1)*m+j)=Kfi(:,8);
%             Kf2(1:M,(i-1)*m+j)=Kf1(j,1);
            windspeed2(1:4,(i-1)*m+j)=windspeed(i,1);
%             windspeed3(1:M,(i-1)*m+j)=windspeed(i,2);
%             frequency1(1:M,(i-1)*m+j)=frequency(:,1);
%             delta_wspeed1(:,(i-1)*m+j)=delta_wspeed(:,4);
%             delta_wspeed2(:,(i-1)*m+j)=delta_wspeed(:,8);
%             delta_Pei1(:,(i-1)*m+j)=delta_Pei(:,1);
%             delta_Pei2(:,(i-1)*m+j)=delta_Pei(:,2);
%             delta_f1(:,(i-1)*m+j)=delta_f(:,1);

    end
    str = ['������...',num2str(i/a*100),'%'];
    waitbar(i/a,wait_title,str); 
end 
delete(wait_title); %ɾ��������
% %%
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.15.xlsx',wspeed1,'���1����ת��');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.15.xlsx',Kfi1,'���1�����´�ϵ��');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.15.xlsx',wspeed2,'���1���ת��');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.15.xlsx',Kfi2,'���1����´�ϵ��');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.15.xlsx',windspeed2,'���1����');

% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx',Kfi1,'���1�´�ϵ��');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx',Kfi2,'���2�´�ϵ��');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx',Kf2,'�´�ϵ��');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx',windspeed2,'���1����');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx',windspeed3,'���2����');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx',frequency1,'Ƶ��');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx',delta_wspeed1,'���1ת�ٸı�');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx',delta_wspeed2,'���2ת�ٸı�');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx',delta_f1,'Ƶ�ʸı�');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx',delta_Pei1,'���1���ʸı�');
% xlswrite('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\Ƶ���½�����10.9.xlsx',delta_Pei2,'���2���ʸı�');
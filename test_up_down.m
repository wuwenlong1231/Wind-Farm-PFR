clear     
%��ȫת��[0.6��1.3]
%% Ƶ���½�
clear
tic
x2=[7.	7.];
% wind1=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\10.25Ƶ���½�ѵ������.xlsx','����1');
% wind2=xlsread('D:\�����ڼ���ֲ���\�������Ĳ���\PES�������\10.25Ƶ���½�ѵ������.xlsx','����2');
% x2(:,1)=wind1(:,1);
% x2(:,2)=wind2(:,1);
for i=1:10
    X2(1,i)=x2(1,1);
    X2(1,i+10)=x2(1,2);
end
for i=1:10
 Kfi(1,i)=1.1631764282356;%1.66   
 Kfi(1,i+10)=1.18778218165971;%2.345
end
Kf=sum(Kfi,2);%13-66
disp(Kf);
[wspeed,frequency,Pe,Pei] =Windfarm_down_new(X2,Kfi);
set(0,'defaultfigurecolor','w')%��ͼ����Ϊ��ɫ
M=300;
x=0.1:0.1:M/10;
  figure(1);
  set(gcf,'unit','centimeters','position',[10 5 10 15]);%����ͼ��С
  subplot(4,1,1);
plot(x,wspeed(1:M,1));
hold on
plot(x,wspeed(1:M,11));
hold on
axis([0 M/10,0.6 inf]);
% xlabel('Times(s)','fontsize',12);
ylabel('\fontname{Times New Roman}Rotor Speed(rad/s)','fontsize',12);
RemoveSubplotWhiteArea(gca, 4, 1, 1, 1);
subplot(4,1,2);
 
% set(gcf,'unit','centimeters','position',[10 5 10 5]);%����ͼ��С
plot(x,frequency(1:M,1),'LineWidth', 1);
hold on
axis([0 M/10,-inf 50]);
% xlabel('ʱ��(s)','fontsize',12);
ylabel('\fontname{Times New Roman}Frequency(Hz)','fontsize',12);
RemoveSubplotWhiteArea(gca, 4, 1, 2, 1);
 subplot(4,1,3);
% set(gcf,'unit','centimeters','position',[10 5 10 5]);%����ͼ��С
plot(x,Pe(1:M,1),'LineWidth', 1);
hold on
% xlabel('ʱ��(s)','fontsize',12);
ylabel('\fontname{Times New Roman}WF Power(KW)','fontsize',12);
RemoveSubplotWhiteArea(gca, 4, 1, 3, 1);
subplot(4,1,4);
% set(gcf,'unit','centimeters','position',[10 5 10 5]);%����ͼ��С
plot(x,Pei(1:M,1),'LineWidth', 1);
hold on
plot(x,Pei(1:M,11),'LineWidth', 1);
hold on
axis([0 M/10,-inf inf]);
xlabel('\fontname{Times New Roman}Times(s)','fontsize',12);
ylabel('\fontname{Times New Roman}WT Power(KW)','fontsize',12);
RemoveSubplotWhiteArea(gca, 4, 1, 4, 1);
% subplot(5,1,5);
% % set(gcf,'unit','centimeters','position',[10 5 10 5]);%����ͼ��С
% plot(x,SOE(1:M,4),'LineWidth', 1);
% hold on
% plot(x,SOE(1:M,8),'LineWidth', 1);
% hold on
% plot(x,SOE(1:M,12),'LineWidth', 1);
% hold on
% plot(x,SOE(1:M,16),'LineWidth', 1);
% hold on
% xlabel('ʱ��(s)','fontsize',12);
% ylabel('SOE','fontsize',12);
% RemoveSubplotWhiteArea(gca, 5, 1, 5, 1);
 disp(wspeed(M+1,1));
 disp(wspeed(M+1,11));
toc
%%
clear
 % Ƶ������
  tic
  x2=[7.2 7.4];
for i=1:10 
    X2(1,i)=x2(1,1);
    X2(1,i+10)=x2(1,2);
end 
for i=1:10
 Kfi(1,i)=5.5;%1.66   
 Kfi(1,i+10)=5.4;%2.345
end
Kf=sum(Kfi,2);
disp(Kf);
[wspeed,frequency,Pe,Pei,Pe2,SOE,Pm,delta_wspeed,Kfi] = Windfarm_up_new(X2,Kfi);
M=300;
set(0,'defaultfigurecolor','w')%��ͼ����Ϊ��ɫ
x=0.1:0.1:M/10;
figure(2);
set(gcf,'unit','centimeters','position',[10 5 10 15]);%����ͼ��С
subplot(4,1,1);

plot(x,wspeed(1:M,1));
hold on
plot(x,wspeed(1:M,11));
hold on
axis([0 M/10,-inf 1.3]);
% set(gca,'YTick',[0.8:0.25:1.3]);
% xlabel('ʱ��(s)','fontsize',12);
ylabel('\fontname{Times New Roman}Rotor Speed(rad/s)','fontsize',12);
RemoveSubplotWhiteArea(gca, 4, 1, 1, 1);
subplot(4,1,2);
% set(gcf,'unit','centimeters','position',[10 5 10 5]);%����ͼ��С
plot(x,frequency(1:M,1),'LineWidth', 1);
hold on
axis([0 M/10,50 inf]);
% xlabel('ʱ��(s)','fontsize',12);
ylabel('\fontname{Times New Roman}Frequency(Hz)','fontsize',12);
RemoveSubplotWhiteArea(gca, 4, 1, 2, 1);
 subplot(4,1,3);
% set(gcf,'unit','centimeters','position',[10 5 10 5]);%����ͼ��С
plot(x,Pe(1:M,1),'LineWidth', 1);
hold on
% xlabel('ʱ��(s)','fontsize',12);
ylabel('\fontname{Times New Roman}WF Power(KW)','fontsize',12);
RemoveSubplotWhiteArea(gca, 4, 1, 3, 1);
 subplot(4,1,4);
% set(gcf,'unit','centimeters','position',[10 5 10 5]);%����ͼ��С
plot(x,Pei(1:M,4),'LineWidth', 1);
hold on
plot(x,Pei(1:M,8),'LineWidth', 1);
hold on
xlabel('\fontname{Times New Roman}Times(s)','fontsize',12);
ylabel('\fontname{Times New Roman}WT Power(KW)','fontsize',12);
RemoveSubplotWhiteArea(gca, 4, 1,4, 1);
 disp(wspeed(M+1,1));
 disp(wspeed(M+1,11));

 toc

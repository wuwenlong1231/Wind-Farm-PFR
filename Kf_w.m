function [Kf,Kfi,Pei0] = Kf_w(windspeed,f1)
%%
%  Kin=0;%输入
%  windspeed=[7.25 7.43 7.62 7.81];%输入
for i=1:4
windspeed1(1,i)=windspeed(1,1);
windspeed1(1,i+4)=windspeed(1,2);
end%风机风速数据
 n=20;%每种风速下循环次数
%  M=3000;
%  f1=1.28;
 [Kf,Kfi,Pei0] = Time_erfenfa(windspeed,f1); %训练末值
%[Kf_max] = Time_erfenfa(windspeed,f0,Kin1); %实际最大值
%测试在时序模型中结果
end
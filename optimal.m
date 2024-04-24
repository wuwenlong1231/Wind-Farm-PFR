function [Kfi]=optimal(frequency,wspeed0,Pm0,Pei,wspeed1)%线性模型得到转速作为约束

%OPTIMAL 此处显示有关此函数的摘要
%   此处显示详细说明
M=50;%滚动点数
f_delta=50.-frequency;
H=sum(f_delta).*2;
f=0;
wmax=1.3;
wmin=0.6;
for i=1:M
    f=2*Pm0*f_delta(i,1)+Pei(i,1)*f_delta(i,1)+f;
end
  for i=1:500
  wspeed=
  end
end


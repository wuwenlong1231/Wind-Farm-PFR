function [Kfi]=optimal(frequency,wspeed0,Pm0,Pei,wspeed1)%����ģ�͵õ�ת����ΪԼ��

%OPTIMAL �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
M=50;%��������
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


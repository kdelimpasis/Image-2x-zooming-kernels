clear all

meth=ones(1,11);
I0=imread('D:\costas\asus_first\iro\dataset\image-processing-benchmark-master\barbara.png');
[Ix2,meth_str]=image2D_zoom_final_fun(I0,meth);
[n1,n2]=size(Ix2,1:2)
% for i=1:length(meth)
%     if meth(i)~=0


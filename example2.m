clear all

I0=imread('D:\costas\asus_first\iro\dataset\image-processing-benchmark-master\barbara.png');
I0=single(I0);
if length(size(I0))==3
    I0=rgb2gray(single(I0));
end
gt=I0;  % V000_gt !!
skip=1;
I=subsampling(I0,skip+1);

a1=7;
a2=size(gt,1)-7;  % min(size(V000_gt,1),size(TaHerm_1,1))-7;
b1=7;
b2=size(gt,2)-7;  % min(size(V000_gt,2),size(TaHerm_1,2))-7;

methods=ones(1,11);
[Ix2,meth_str]=image2D_zoom_final_fun(I,methods);
% gt=repmat(V000,1,1,size(Ix2,3));
for m=1:length(methods)
    if methods(m)~=0
        mae(m)=mean2(abs(gt(a1:a2,b1:b2)-Ix2(a1:a2,b1:b2,m)));
        psnr(m)=10*log10(max(gt(:))^2/mean2(abs(Ix2(a1:a2,b1:b2,m)-double(gt(a1:a2,b1:b2))).^2));
        fprintf('%s: %2.4f  %2.4f \n',meth_str{m},mae(m),psnr(m));
    end

end

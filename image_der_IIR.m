function [I10,I01,I11,I20,I02,I12,I21,I22,I30,I03,I13,I31,I23,I32,I33]=image_der_IIR(I,n1,n2)
% image derivation by 2 applications of 1D masks 
% for 1st order and 2nd order 
% n1: order of deriv 1; 
% n2: order of deriv 2; 
% I10 deriv 1 by lines
% I01 deriv 1 by columns

[Nlin,Ncol]=size(I);
I10=zeros(size(I));
I01=zeros(size(I));
I20=zeros(size(I));
I02=zeros(size(I));
I11=zeros(size(I));
I12=zeros(size(I));
I21=zeros(size(I));
I22=zeros(size(I));
for i=1:Nlin
    I10(i,:)=deriv_compact(I(i,:),1,n1);
    I20(i,:)=deriv_compact(I(i,:),2,n2);
end

for i=1:Ncol
    I01(:,i)=deriv_compact(I(:,i),1,n1);
    I02(:,i)=deriv_compact(I(:,i),2,n2);
end

for i=1:Ncol
    I11(:,i)=deriv_compact(I10(:,i),1,n1);
    I21(:,i)=deriv_compact(I20(:,i),1,n1); 
    I22(:,i)=deriv_compact(I20(:,i),2,n2);
end

for i=1:Nlin
    I12(i,:)=deriv_compact(I02(i,:),1,n1);
end

% I12=zeros(size(I));
% I21=zeros(size(I));
% I22=zeros(size(I));

% fid=fopen('circ_pat01.raw','r');
% I01=-fread(fid,[512,512],'double');
% fclose(fid);
% fid=fopen('circ_pat10.raw','r');
% I10=-fread(fid,[512,512],'double');
% fclose(fid);

% --------3rd derivative --
I30=zeros(size(I));
I03=zeros(size(I));
I13=zeros(size(I));
I31=zeros(size(I));
I23=zeros(size(I));
I32=zeros(size(I));
I33=zeros(size(I));
% I30=imfilter(I , m3 ,'conv','replicate');
% I03=imfilter(I , m3','conv','replicate');
% I13=imfilter(I10,m3','conv','replicate');
% I31=imfilter(I01,m3 ,'conv','replicate');
% I23=imfilter(I20,m3','conv','replicate');
% I32=imfilter(I02,m3 ,'conv','replicate');
% I33=imfilter(I03,m3 ,'conv','replicate');



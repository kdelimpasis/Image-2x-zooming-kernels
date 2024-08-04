function [I10,I01,I11,I20,I02,I12,I21,I22,I30,I03,I13,I31,I23,I32,I33]=image_der(I,n1,n2)
% image derivation by 2 applications of 1D masks 
% for 1st order and 2nd order 
% n1: order of deriv 1; 
% n2: order of deriv 2; 
% I10 deriv 1 by lines
% I01 deriv 1 by columns

% if n1==5
%     m1=1.2*[-1,8,0,-8,1]/12;
% end
% m3=2*[-1,8,-13,0,13,-8,1]/8;
% 
% if n1==7
%     m1=1.2*[1,-9,45,0,-45,9,-1]/60; % 1.2 m1=fliplr(m1);
% end
% if n1==9
%     m1=1.2*[-3,32,-168,672,0,-672,168,-32,3]/840;
% end
% if n2==5
%     m2=0.8*[-1,16,-30,16,-1]/12;
% end
% if n2==7
%    m2=0.75*[1,-27/2,135,-245,135,-27/2,1]/90;   % 0.8 m2=fliplr(m2);
% end
% if n2==11
%     m2=1*deriv2_order10;
% end

m1=1.0*descrete_deriv(1,n1);   %1.1

I10=imfilter(I , m1,'conv','replicate');
I01=imfilter(I , m1','conv','replicate');
I11=imfilter(I10, m1','conv','replicate');

% ----- 2nd deriv ---
I20=zeros(size(I));
I02=zeros(size(I));
I12=zeros(size(I));
I21=zeros(size(I));
I22=zeros(size(I));
if n2>0
    m2=1.0*descrete_deriv(2,n2);
    I20=imfilter(I , m2 ,'conv','replicate');
    I02=imfilter(I,  m2','conv','replicate');
    I12=imfilter(I10,m2','conv','replicate');
    I21=imfilter(I01,m2 ,'conv','replicate');
    I22=imfilter(I02,m2 ,'conv','replicate');
end

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


% function c=deriv2_order10
% c=[0.00031746031746,
% -0.00496031746032,
% 0.03968253968254,
% -0.23809523809525,
% 1.66666666666668];
% c=[c',2*sum(c),fliplr(c')];

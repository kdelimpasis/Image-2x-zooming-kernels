function [Ta,V000_gt]=creat_deriveative_2D_fun(I0,skip,gg)
% skip: 0: do not subsample
% skip: integer >0: do subsample by a factor =skip+1


    I0=single(I0);


flag_incude_deriv=1;

% s=dir('D:\costas\asus_first\iro\derivatives_3D\DICOM\files\*.ima');
% s=dir('D:\costas\asus_first\iro\frame_interpolation\InterpScImgDB-master\exampleDataset\Asteroid\orig\*.png');
% s=dir('..\frame_interpolation\InterpScImgDB-master\exampleDataset\Asteroid\orig\*.png');

% I0=single(imread('D:\costas\asus_first\iro\3dsplinesimpl_27112022\cat.jpg'));
% I0=single(imread('D:\costas\asus_first\iro\derivatives_3D\papagal.png'));
% I0=single(rgb2gray(imread('D:\costas\asus_first\iro\data\brain_tumor\brain_tumor_dataset\yes\Y1.jpg')));
% ';

V000_gt=I0;  % !!

if skip>1  % 0
    I=subsampling(I0,skip+1);    
    V000=I;  % V000_gt;
else
    % I0=I;
    V000=I0;
end

if flag_incude_deriv==1
tic

    I1=V000(:,:);
    % [I10,I01,I11,I20,I02,I12,I21,I22,I30,I03,I13,I31,I23,I32,I33]=image_der(I1,5,5);
    [I10,I01,I11,I20,I02,I12,I21,I22,I30,I03,I13,I31,I23,I32,I33]=image_der_IIR(I1,10,10);
    V010=I01;
    V100=I10;
    V110=I11;

    miden=zeros(size(V000));
    V001=miden;
    V101=V001;
    V011=V001;
    V111=V001;


fprintf('\n')
% Ta=cat(4,V000,V001,V010,V100,V011,V101,V110,V111);
%          1    2      3    4    5    6     7    8    9   10
Ta=cat(4,V000,miden, V010,V100,miden,miden,miden,I02,I11,I20, ...
    miden,miden,miden,miden,miden,I12,I21,...
    miden,miden,miden,miden,miden,I22,...
    miden,miden,miden,miden);
end

% V000_gt=uint8(V000_gt);
% save D:\costas\asus_first\iro\3dsplinesimpl_27112022\Ta_asteroids_B.mat Ta
% save(['..\3dsplinesimpl_27112022\cat_2D_IIR',num2str(skip),'.mat'], 'Ta', 'V000_gt', '-v7.3')
% save(['..\3dsplinesimpl_27112022\cat_2D_IIR_maxord_3_',num2str(skip),'.mat'], 'Ta', 'V000_gt', '-v7.3')

% save(['.\cat_2D_FIR_maxord_3_',num2str(skip),'_subsample_.mat'], 'Ta', 'V000_gt', '-v7.3')
% save(['.\papagal_2D_IIR_maxord_3_',num2str(skip),'_subsample_.mat'], 'Ta', 'V000_gt', '-v7.3')
% save(['.\SITE2-000267_02-10-2002-81231_1.000000-14867_000000_',num2str(skip),'_subsample_.mat'], 'Ta', 'V000_gt', '-v7.3')

% save(['..\3dsplinesimpl_27112022\brain_Y1_2D_FIR_maxord_3_',num2str(skip),'.mat'], 'Ta', 'V000_gt', '-v7.3')



%%



toc

if gg==1 
    figure; imshow([I10,I01,I11;I20,I02,I22],[])
end

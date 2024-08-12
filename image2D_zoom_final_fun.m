function [Ix2,meth_str]=image2D_zoom_final_fun(I,all_meth)

meth_str={'Hermite','Nearest','bilinear','bicubic','OMOM4','OMOM5','OMOM7',...
'B-Spline deg=3','B-Spline deg=5','Cubic poly deg=3 8-point','bicubic mine'};


% 1 Hermite
% 2 nearest
% 3 bilinear
% 4 bicubic
% 5 OMOM4
% 6 OMOM5
% 7 OMOM7
% 8 B-Spline deg=3
% 9 B-Spline deg=5
% 10 Cubic poly deg=3, 8-point
% 11 bicubic mine

load kernels_v2.mat
load kernels_herm_IIR.mat

% if RGB convert input image --> single, gray scale
if size(I,3)==3
    I=rgb2gray(I);
end
I=single(I);

skip=1;
Ta0=I;
Ta00=Ta0;
[Ta,~]=creat_deriveative_2D_fun(I,skip,0);

% % OMOM4
% meth=zeros(1,28);
% meth(17)=1;
% S22=omom_prefilter_2D(double(Ta0),meth);
% T_right=conv2(S22,flipud(fliplr(K_omom_4_right)),'same');
% T_down=conv2(S22,flipud(fliplr(K_omom_4_down)),'same');
% T_right_down=conv2(S22,flipud(fliplr(K_omom_4_right_down)),'same');
% [Nlin,Ncol]=size(Ta0);
% Taomo4=zeros(2*size(Ta0,1),2*size(Ta0,2));
% Taomo4(1:2:Nlin*2,1:2:2*Ncol)=Ta0;
% Taomo4(2:2:Nlin*2,1:2:2*Ncol)=T_down;
% Taomo4(1:2:Nlin*2-1,2:2:2*Ncol)=T_right;
% Taomo4(2:2:Nlin*2,2:2:2*Ncol)=T_right_down;
% % TaOMO4(:,:,rep)=Taomo4;



[Ta,~]=creat_deriveative_2D_fun(I,skip,0);
% fname_out_png=['D:\costas\asus_first\iro\dataset\image-processing-benchmark-master_subsample2\',sdir(fi).name(1:end-4),'_subsample2.png'];
% fname_out_raw=['D:\costas\asus_first\iro\dataset\image-processing-benchmark-master_subsample2\',sdir(fi).name(1:end-4),'_subsample2.raw'];
% fname_out_mat=['D:\costas\asus_first\iro\dataset\image-processing-benchmark-master_subsample2\',sdir(fi).name(1:end-4),'_subsample2.mat'];
% imwrite(uint8(I),fname_out_png);
% fid=fopen(fname_out_raw,'wb');
% fwrite(fid,I,'double');
% fclose(fid);
% save(fname_out_mat,'I');
Ta0=I;
Ta00=Ta0; 

if all_meth(2)==1
% nearest neib

    Ta0=Ta00;

[Nlin,Ncol]=size(Ta0);
Tanearest=zeros(2*size(Ta0,1),2*size(Ta0,2));
Tanearest(1:2:Nlin*2,1:2:2*Ncol)=Ta0;
Tanearest(2:2:Nlin*2,1:2:2*Ncol)=Ta0;
Tanearest(1:2:Nlin*2-1,2:2:2*Ncol)=Ta0;
Tanearest(2:2:Nlin*2,2:2:2*Ncol)=Ta0;
Ix2(:,:,2)=Tanearest;
end

% OMOM4
if all_meth(5)==1

    Ta0=Ta00;

    meth=zeros(1,28);
    meth(17)=1;
    S22=omom_prefilter_2D(double(Ta0),meth);
    WW_right=K_omom_4_right;  % construct_omom4_kernel(0.5, 0, 4);
    T_right=conv2(S22,flipud(fliplr(WW_right)),'same');

    WW_down=K_omom_4_down;  % construct_omom4_kernel(0, 0.5, 4);
    T_down=conv2(S22,flipud(fliplr(WW_down)),'same');

    WW_right_down=K_omom_4_right_down;  % construct_omom4_kernel(0.5, 0.5, 4);
    T_right_down=conv2(S22,flipud(fliplr(WW_right_down)),'same');

    % figure; imshow([Ta0,T_right;T_down,T_right_down],[]); title('omom 7');

    [Nlin,Ncol]=size(Ta0);
    Taomo4=zeros(2*size(Ta0,1),2*size(Ta0,2));
    Taomo4(1:2:Nlin*2,1:2:2*Ncol)=Ta0;
    Taomo4(2:2:Nlin*2,1:2:2*Ncol)=T_down;
    Taomo4(1:2:Nlin*2-1,2:2:2*Ncol)=T_right;
    Taomo4(2:2:Nlin*2,2:2:2*Ncol)=T_right_down;
    Ix2(:,:,5)=Taomo4;
end


% OMOM5
if all_meth(6)==1

    Ta0=Ta00;

    meth=zeros(1,28);
    meth(20)=1;
    S22=omom_prefilter_2D(double(Ta0),meth);
    WW_right=K_omom_5_right;  % construct_omom5_kernel(0.5, 0, 5);
    T_right=conv2(S22,flipud(fliplr(WW_right)),'same');

    WW_down=K_omom_5_down;  % construct_omom5_kernel(0, 0.5, 5);
    T_down=conv2(S22,flipud(fliplr(WW_down)),'same');

    WW_right_down=K_omom_5_right_down;  % construct_omom5_kernel(0.5, 0.5, 5);
    T_right_down=conv2(S22,flipud(fliplr(WW_right_down)),'same');

    % figure; imshow([Ta0,T_right;T_down,T_right_down],[]); title('omom 7');

    [Nlin,Ncol]=size(Ta0);
    Taomo5=zeros(2*size(Ta0,1),2*size(Ta0,2));
    Taomo5(1:2:Nlin*2,1:2:2*Ncol)=Ta0;
    Taomo5(2:2:Nlin*2,1:2:2*Ncol)=T_down;
    Taomo5(1:2:Nlin*2-1,2:2:2*Ncol)=T_right;
    Taomo5(2:2:Nlin*2,2:2:2*Ncol)=T_right_down;
    Ix2(:,:,6)=Taomo5;
end
    
% OMOM7
if all_meth(7)==1

    Ta0=Ta00;

    meth=zeros(1,28);
    meth(24)=1;
    S22=omom_prefilter_2D(double(Ta0),meth);
    WW_right=K_omom_7_right;  % construct_omom7_kernel(0.5, 0);
    T_right=conv2(S22,flipud(fliplr(WW_right)),'same');

    WW_down=K_omom_7_down;  % construct_omom7_kernel(0, 0.5);
    T_down=conv2(S22,flipud(fliplr(WW_down)),'same');

    WW_right_down=K_omom_7_right_down;  % construct_omom7_kernel(0.5, 0.5);
    T_right_down=conv2(S22,flipud(fliplr(WW_right_down)),'same');

    % figure; imshow([Ta0,T_right;T_down,T_right_down],[]); title('omom 7');

    [Nlin,Ncol]=size(Ta0);
    Taomo=zeros(2*size(Ta0,1),2*size(Ta0,2));
    Taomo(1:2:Nlin*2,1:2:2*Ncol)=Ta0;
    Taomo(2:2:Nlin*2,1:2:2*Ncol)=T_down;
    Taomo(1:2:Nlin*2-1,2:2:2*Ncol)=T_right;
    Taomo(2:2:Nlin*2,2:2:2*Ncol)=T_right_down;
    Ix2(:,:,7)=Taomo;
end

% ---B-Spline deg=3 ----------------------------
if all_meth(8)==1

    Ta0=Ta00;

    meth(18)=1;
    S22=omom_prefilter_2D(double(Ta0),meth);
    WW_right=K_bspline_3_right;  % construct_bspline3_kernel(0.5, 0);
    T_right=conv2(S22,flipud(fliplr(WW_right)),'same');

    WW_down=K_bspline_3_down;  % construct_bspline3_kernel(0, 0.5);
    T_down=conv2(S22,flipud(fliplr(WW_down)),'same');

    WW_right_down=K_bspline_3_right_down;  % construct_bspline3_kernel(0.5, 0.5);
    T_right_down=conv2(S22,flipud(fliplr(WW_right_down)),'same');

    % figure; imshow([Ta0,T_right;T_down,T_right_down],[]); title('bsline 3');

    [Nlin,Ncol]=size(Ta0);
    Tabspl3=zeros(2*size(Ta0,1),2*size(Ta0,2));
    Tabspl3(1:2:Nlin*2,1:2:2*Ncol)=Ta0;
    Tabspl3(2:2:Nlin*2,1:2:2*Ncol)=T_down;
    Tabspl3(1:2:Nlin*2-1,2:2:2*Ncol)=T_right;
    Tabspl3(2:2:Nlin*2,2:2:2*Ncol)=T_right_down;
    Ix2(:,:,8)=Tabspl3;
end


% ---B-Spline deg=5 ----------------------------
if all_meth(9)==1

    Ta0=Ta00;

    meth=zeros(1,28);
    meth(22)=1;
    S22=omom_prefilter_2D(double(Ta0),meth);
    WW_right=K_bspline_5_right;  % construct_bspline5_kernel(0.5, 0, 5);
    T_right=conv2(S22,flipud(fliplr(WW_right)),'same');

    WW_down=K_bspline_5_down;  % construct_bspline5_kernel(0, 0.5, 5);
    T_down=conv2(S22,flipud(fliplr(WW_down)),'same');

    WW_right_down=K_bspline_5_right_down;  % construct_bspline5_kernel(0.5, 0.5, 5);
    T_right_down=conv2(S22,flipud(fliplr(WW_right_down)),'same');

    % figure; imshow([Ta0,T_right;T_down,T_right_down],[]); title('bsline 3');

    [Nlin,Ncol]=size(Ta0);
    Tabspl5=zeros(2*size(Ta0,1),2*size(Ta0,2));
    Tabspl5(1:2:Nlin*2,1:2:2*Ncol)=Ta0;
    Tabspl5(2:2:Nlin*2,1:2:2*Ncol)=T_down;
    Tabspl5(1:2:Nlin*2-1,2:2:2*Ncol)=T_right;
    Tabspl5(2:2:Nlin*2,2:2:2*Ncol)=T_right_down;
    Ix2(:,:,9)=Tabspl5;
end

%%

% ---Cubic poly deg=3, 8-point -------------
if all_meth(10)

    Ta0=Ta00;

    WW_right=K_cub8p_right;  % construct_kernel_cubic_8point(0.5, 0);
    T_right=conv2(Ta0,flipud(fliplr(WW_right)),'same');

    WW_down=K_cub8p_down;  % construct_kernel_cubic_8point(0, 0.5);
    T_down=conv2(Ta0,flipud(fliplr(WW_down)),'same');

    WW_right_down=K_cub8p_right_down;  % construct_kernel_cubic_8point(0.5, 0.5);
    T_right_down=conv2(Ta0,flipud(fliplr(WW_right_down)),'same');

    % figure; imshow([Ta0,T_right;T_down,T_right_down],[]); title('cub 8p')

    [Nlin,Ncol]=size(Ta0);
    Tacub8p=zeros(2*size(Ta0,1),2*size(Ta0,2));
    Tacub8p(1:2:Nlin*2,1:2:2*Ncol)=Ta0;
    Tacub8p(2:2:Nlin*2,1:2:2*Ncol)=T_down;
    Tacub8p(1:2:Nlin*2-1,2:2:2*Ncol)=T_right;
    Tacub8p(2:2:Nlin*2,2:2:2*Ncol)=T_right_down;
    Ix2(:,:,10)=Tacub8p;
end
%%

% ----- Bilinear   -------------
if all_meth(3)==1

    Ta0=Ta00;

    WW_right=K_lin_right;  % construct_kernel_bilinear(0.5, 0);
    T_right=conv2(Ta0,WW_right,'same');

    WW_down=K_lin_right_down;  % construct_kernel_bilinear(0, 0.5);
    T_down=conv2(Ta0,WW_down,'same');

    WW_right_down=K_lin_right_down;  % construct_kernel_bilinear(0.5, 0.5);
    T_right_down=conv2(Ta0,WW_right_down,'same');

    % figure; imshow([Ta0,T_right;T_down,T_right_down],[]); title('bilinear')

    [Nlin,Ncol]=size(Ta0);
    Ta_bilin_mine=zeros(2*size(Ta0,1),2*size(Ta0,2));
    Ta_bilin_mine(1:2:Nlin*2,1:2:2*Ncol)=Ta0;
    Ta_bilin_mine(2:2:Nlin*2,1:2:2*Ncol)=T_down;
    Ta_bilin_mine(1:2:Nlin*2-1,2:2:2*Ncol)=T_right;
    Ta_bilin_mine(2:2:Nlin*2,2:2:2*Ncol)=T_right_down;
    Ix2(:,:,3)=Ta_bilin_mine;
end
%%



%%
if all_meth(11)==1

    Ta0=Ta00;

    WW_right=K_bicub_right;  % construct_kernel_bicubic_simple(0,0.5);
    T_right=conv2(Ta0,WW_right,'same');

    WW_down=K_bicub_down;  % construct_kernel_bicubic_simple(0, 0.5);
    T_down=conv2(Ta0,WW_down,'same');

    WW_right_down=K_bicub_right_down;  % construct_kernel_bicubic_simple(0.5, 0.5);
    T_right_down=conv2(Ta0,WW_right_down,'same');

    % figure; imshow([Ta0,T_right;T_down,T_right_down],[]); title('bicubic mine');

    [Nlin,Ncol]=size(Ta0);
    Ta_bicubic_mine=zeros(2*size(Ta0,1),2*size(Ta0,2));
    Ta_bicubic_mine(1:2:Nlin*2,1:2:2*Ncol)=Ta0;
    Ta_bicubic_mine(2:2:Nlin*2,1:2:2*Ncol)=circshift(T_down,[0,0]);
    Ta_bicubic_mine(1:2:Nlin*2-1,2:2:2*Ncol)=circshift(T_right,[0,0]);
    Ta_bicubic_mine(2:2:Nlin*2,2:2:2*Ncol)=circshift(T_right_down,[0,0]);

    Ix2(:,:,11)=Ta_bicubic_mine;
    % circshift(CC01,[-1,0])
end
%%


% if rep==1
%     Ta0=Ta00;
% end
% Ta_bilin=imresize(Ta0,2,'bilinear');
% TaBILIN(:,:,rep)=Ta_bilin;
% 
% 
% if rep==1
%     Ta0=Ta00;
% else
%     I=subsampling(Ta_bicub,skip+1);
%     [Ta,~]=creat_deriveative_2D_fun(I,skip,0);
%     Ta0=I;
% end
% Ta_bicub=imresize(Ta0,2,'bicubic');
% 

if all_meth(1)==1
nk=size(KK10_flipped,4);
% KK10_flipped = flipdim(flipdim(KK10, 1), 2);
for sli=1:nk  % 8
%     slic=slic+1;
    % C1=convn(squeeze(Taperm(sli,:,:)),squeeze(KK10_flipped(:,:,sli)),'same');
    C1=convn(squeeze(Ta(:,:,1,sli)),squeeze(KK10_flipped(:,:,:,sli)),'same');
    if sli==1
        CC10=C1;
    else
        CC10=CC10+C1;
    end
end


% KK01_flipped = flipdim(flipdim(KK01, 1), 2);
for sli=1:nk
%     slic=slic+1;
    % C1=convn(squeeze(Taperm(:,:,:,sli)),squeeze(KK01_flipped(:,:,sli)),'same');
    C1=convn(squeeze(Ta(:,:,1,sli)),squeeze(KK01_flipped(:,:,:,sli)),'same');
    if sli==1
        CC01=C1;
    else
        CC01=CC01+C1;
    end
end


% KK11_flipped = flipdim(flipdim(KK11, 1), 2);
for sli=1:nk
%     slic=slic+1;
    % C1=convn(squeeze(Taperm(:,:,:,sli)),squeeze(KK11_flipped(:,:,sli)),'same');
    C1=convn(squeeze(Ta(:,:,1,sli)),squeeze(KK11_flipped(:,:,:,sli)),'same');
    if sli==1
        CC11=C1;
    else
        CC11=CC11+C1;
    end
end


TaHerm=zeros(2*size(Ta0,1),2*size(Ta0,2));
TaHerm(1:2:Nlin*2,1:2:2*Ncol)=Ta(:,:,1,1);  % double(Ta0);
% TaHerm(2:2:Nlin*2,1:2:2*Ncol)=CC01;
% TaHerm(1:2:Nlin*2-1,2:2:2*Ncol)=CC10;
% TaHerm(2:2:Nlin*2,2:2:2*Ncol)=CC11;

TaHerm(2:2:Nlin*2,1:2:2*Ncol)=circshift(CC01,[-1,0]);
TaHerm(1:2:Nlin*2-1,2:2:2*Ncol)=circshift(CC10,[0,-1]);
TaHerm(2:2:Nlin*2,2:2:2*Ncol)=circshift(CC11,[-1,-1]);
Ix2(:,:,1)=TaHerm;
end





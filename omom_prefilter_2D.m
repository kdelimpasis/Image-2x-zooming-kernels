function S22=omom_prefilter_2D(I,method)
[Nlin,Ncol]=size(I);

% 

if method(18)==1                   % Bspline, by Unser, deg=3
    val_at_max_dist=1/6;
    riza=[-0.267949];
elseif method(23)==1               % bspline 7
    val_at_max_dist=bspline_at(3,7);
    riza=[-0.53528, -0.12255, -0.009148];
elseif method(17)==1               % oMOM deg 4
    val_at_max_dist=omoms_at(2,4);
    riza=[-0.031684909102439,-0.410549185795630];
elseif method(24)==1           % oMOMs 7
    val_at_max_dist=omoms7_at(3,7);
    riza=[-0.568507375495346, -0.155672207701469, -0.019788989863973];
elseif method(20)==1           % oMOMs 5
    val_at_max_dist=omoms_at(3,5);
    riza=[-0.4786428873962,-0.0687446488761,-0.0012007460216];
elseif method(22)==1           % bspline 5
    val_at_max_dist=bspline_at(2,5);
    riza=[-0.430575347099975, -0.043096288203264];
end

% bspline 7  method(23)==1     
% val_at_max_dist=bspline_at(3,7);
% riza=[-0.53528, -0.12255, -0.009148];


%% filter along COLS

    for ii=1:Nlin
        s=I(ii,:);
        N=length(s);
        s_mirror=s;   % [fliplr(s(1:end)),s,fliplr(s(1:end-1))];
        ind_offset=0;   % N;
        ind=1:Ncol;    
            
            s2=s_mirror;
            for i=length(riza):-1:1
                s2=causal_anticausal_filter_IIR(s2,ind_offset,N,riza(i));
            end
            s2(ind_offset+ind)=s2(ind_offset+ind)/val_at_max_dist;
        
        S2(ii,:)=s2;
    end


    % filter along LINES

    for ii=1:Ncol
        s=squeeze(S2(:,ii+ind_offset));
        N=length(s);
        s_mirror=s;   % [fliplr(s(1:end));s;fliplr(s(1:end-1))];
        ind_offset=0;   % N;
        ind=1:Nlin;
        s2=s_mirror;
        for i=length(riza):-1:1
            s2=causal_anticausal_filter_IIR(s2',ind_offset,N,riza(i));
        end
        s2(ind_offset+ind)=s2(ind_offset+ind)/val_at_max_dist;
        
        S2(:,ii)=s2;
    end


%     % filter along 3rd dim
%     for ii=1:Nlin
%     for jj=1:Ncol
%         s=squeeze(S2(ii+ind_offset,jj+ind_offset,:));
%         N=length(s);
%         s_mirror=s;   % [fliplr(s(1:end));s;fliplr(s(1:end-1))];
%         ind_offset=0;   % N;
%         ind=1:N;
%         s2=s_mirror;
%         for i=length(riza):-1:1
%             s2=causal_anticausal_filter_IIR(s2',ind_offset,N,riza(i));
%         end
%         s2(ind_offset+ind)=s2(ind_offset+ind)/val_at_max_dist;
%         
%         S2(ii,jj,:)=s2;
%     end
%     end
    
    S22=S2(ind_offset+1:ind_offset+Nlin,ind_offset+1:ind_offset+Ncol);

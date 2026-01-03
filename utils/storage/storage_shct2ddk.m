function [ddk_shc]=storage_shct2ddk(shc,maxn)
% [ddk_shc]=storage_shct2ddk(shc,maxn)
%----------------------------------------------------------------------------
% In   : shct       [struct{cnm;snm}]   struct in shct-format
% Out  : shc_ddk    [struct{C;S}]       struct in DDK-format
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-20
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************


ntime=length(shc);
ddk_shc.C=zeros(maxn+1,maxn+1,ntime);
ddk_shc.S=zeros(maxn+1,maxn+1,ntime);


for tt=1:ntime
    % cs=storage_shc2cs(shc(tt));
    % [clm]=storage_shc2clm(shc(tt),maxn)         ;
    % [sc]=storage_clm2sc(clm, maxn);
    [sc]=storage_shc2sc(shc(tt),maxn) ; %20250825;

    ddk_shc.C(:,:,tt)=sc(:,maxn+1:end);
    ddk_shc.S(:,:,tt)=[zeros(maxn+1,1) fliplr(sc(:,1:maxn))];

end
end


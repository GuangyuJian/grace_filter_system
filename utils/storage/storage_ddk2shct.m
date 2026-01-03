function [shct]=storage_ddk2shct(shc_ddk)
%
%----------------------------------------------------------------------------
% In   : shc_ddk    [struct{C;S}]  struct in DDK-format
% Out  :
%        shct       [struct{cnm;snm}]   struct in shct-format
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-20
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************

ntime=size(shc_ddk.C,3);

for tt=1:ntime
    sc=[fliplr(shc_ddk.S(:,2:end,tt)) shc_ddk.C(:,:,tt) ];
    cs=storage_sc2cs(sc);
    [shct(tt).cnm, shct(tt).snm,~]=storage_cs2vec(cs);

end

end


function [shct]=storage_sht2shct(sht)
% [shct]=storage_sht2shct(sht)
%----------------------------------------------------------------------------
% In   :
%
% Out  :
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Sun Yat-sen University   (SYSU)
% email: temp~~
% supervisor: Min zhong
%----------------------------------------------------------------------------
% address: Guangdong University of Technology(GDUT)
% email:   gyjian@mail2.gdut.edu.cn
% supervisor: Chuang Xu
% date: 2024-04-15
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

% loc1=size(sht,1)/2;
ntime=size(sht,2);
for t=1:ntime
    %     shct(t).cnm=sht(1:loc1,t);
    %     shct(t).snm=sht(1+loc1:end,t);
    [shct(t)]=storage_sh2shc(sht(:,t));
end



end


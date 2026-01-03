function [sc]=storage_clm2sc(clm, maxn)
% [sc]=storage_clm2sc(clm, maxn)
% -------------------------------------------------------------------------
% storage_clm2sc converts a list of coefficients in clm-format to /S|C\-format
% and--if available--does the same with the standard deviations.
% IN:
%    clm ............ matrix   [en x 4]
%                               coefficients in clm-format ([n; m; cnm; snm] )
%    maxn .......     double   [1  x 1]
%                               maximum of degree
% OUT (standard):
%    sc ............. matrix   [maxn+1 x maxn*2+1]
%                              coefficients in /S|C\ format
% EXAMPLE:
%    storage_clm2sc(clm, 60);
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-10
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************

sc=zeros(maxn+1,maxn*2+1);
for k=1:size(clm,1)
    nn=clm(k,1);
    mm=clm(k,2);
    ccoe=clm(k,3);
    scoe=clm(k,4);

    sc(nn+1,maxn+1+mm)=ccoe;
    if mm>0
        %         sc(nn+1,maxn+1-mm)=scoe;
        sc(nn+1,maxn+1-mm)=scoe;
    end
end


end


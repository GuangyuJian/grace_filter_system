function [sc]=storage_cs2sc(cs)                               
% [sc]=storage_cs2sc(cs)                                   
% storage_cs2sc converts the square (L+1)x(L+1) matrix, containing
% spherical harmonics coefficients in |C\S| storage format into a 
% rectangular (L+1)x(2L+1) matrix in  /S|C\format.
%--------------------------------------------------------------------------
% IN:
%    cs ............. matrix   [ maxn+1 x maxn+1] 
%                              coefficients in C\S format
% OUT: 
%    sc ............. matrix   [maxn+1 x maxn*2+1] 
%                              coefficients in /S|C\ format                    
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-10
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
                     

[rows,cols] = size(cs);
if rows~=cols
    error('!');
else
    maxn = rows-1;
    c    = tril(cs);
    s    = rot90(triu(cs,1),-1);
    sc   = [s(:,2:maxn+1) c];
end                        
                              
end


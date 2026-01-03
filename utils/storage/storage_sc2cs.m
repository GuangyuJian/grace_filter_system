function [cs]=storage_sc2cs(sc)                               
% [cs, rows, cols]=storage_sc2cs(sc)     
% storage_sc2cs converts the rectangular (L+1)x(2L+1) matrix FIELD, containing
% spherical harmonics coefficients in /S|C\ storage format into a 
% square (L+1)x(L+1) matrix in |C\S| format.
%--------------------------------------------------------------------------
% IN:
%    sc ............. matrix   [maxn+1 x maxn*2+1] 
%                              coefficients in /S|C\ format    
% OUT: 
%    cs ............. matrix   [ maxn+1 x maxn+1] 
%                              coefficients in C\S format
%----------------------------------------------------------------------------
   

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-10
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
                      
[rows,cols] = size(sc);  
if (cols~=2*rows-1)
    error('!');
else
    maxn = rows-1;
    c    = sc(:,maxn+1:2*maxn+1);
    s    = [zeros(maxn+1,1) sc(:,1:maxn)];
    cs   = tril(c) + triu(rot90(s),1);    
end

end


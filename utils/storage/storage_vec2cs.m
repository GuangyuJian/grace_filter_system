function [cs]=storage_vec2cs(nm,vecc,vecs)
% [cs]=storage_vec2cs(nm,vecc,vecs)
%----------------------------------------------------------------------------
% storage_vec2cs rearranges a vector shaped set of spherical harmonic
% coefficients into cs-format. The vector order is given by the ordering
% vector.
%
% IN:
%    vecc ..... coefficients in vector shape: cosine part   [en x 1]
%    vecs ..... coefficients in vector shape: sine part     [en x 1]
%    nm ......  ordering vector                             [en x 2]
% OUTPUT:
%    cs ............. matrix                        [ maxn+1 x maxn+1] 
%                              coefficients in C\S format
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-10
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************

for k=1:length(vecc)
    nn=nm(k,1);
    mm=nm(k,2);
    cs(nn+1,mm+1)=vecc(k);
    
    if mm~=0
    cs(mm,nn+1)=vecs(k);
    end

end

end


function [vecc,vecs,nm]=storage_cs2vec(cs)
% [vecc,vecs,nm]=storage_cs2vec(cs)
% storage_cs2vec rearranges a field of spherical harmonic coefficients in
% cs-format to a vector shape in degree-dependent order. 
%----------------------------------------------------------------------------
% IN:
%    cs ............. matrix   [ maxn+1 x maxn+1] 
%                              coefficients in C\S format
% OUTPUT:
%    vecc ..... coefficients in vector shape: cosine part            [en x 1]
%    vecs ..... coefficients in vector shape: sine part              [en x 1]
%    nm ...... ordering vector                                       [en x 2]
%    
%   notes: vecc=[c00 c10 c11 c20 c21 c22 ----- cmaxn,maxn]T
%           nm=[0 1 1 2 2 2 3 3 3 ----      maxn   maxn]T
%              [0 0 1 0 1 2 0 1 2 ----      maxn-1 maxn]
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-10
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
% change log 
%   1 20250305 kj
%       pre assign the storage of vecc vecs
%**************************************************************************
[rows,~]=size(cs);
maxn=rows-1;
en=get_en(maxn);

vecc=zeros(en,1);
vecs=zeros(en,1);

k=0;
for nn=0:maxn
    for mm=0:nn
        k=k+1;

        nm(k,1)=nn;
        nm(k,2)=mm;
        vecc(k,1)=cs(nn+1,mm+1);
        if mm~=0
            vecs(k,1)=cs(mm,nn+1);
        end

    end


end


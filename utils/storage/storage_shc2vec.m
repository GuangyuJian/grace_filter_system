function [vecc,vecs,nm]=storage_shc2vec(shc,maxn)
%----------------------------------------------------------------------------
% In   :    shc     [struct{cnm;snm}]
%                   a structure storages values of c and s
%                   (stored as degree-leading format) in its subfield
%                   shc.cnm and shc.snm, respectively.
%           maxn     [1x1] maximum degree
% OUTPUT:
%    vecc ..... coefficients in vector shape: cosine part            [en x 1]
%    vecs ..... coefficients in vector shape: sine part              [en x 1]
%    nm ...... ordering vector                                       [en x 2]
%    
%   notes: vecc=[c00 c10 c11 c20 c21 c22 ----- cmaxn,maxn]T
%           nm=[0 1 1 2 2 2 3 3 3 ----      maxn   maxn]T
%              [0 0 1 0 1 2 0 1 2 ----      maxn-1 maxn]
%   
%                   Lmax means maximum degree
%                   e.g.,shc(i).cnm
%                           =[  c00(i)  ]
%                            [  c10(i)  ]
%                            [  ...     ]
%                            [  cLmaxLmax(i)]
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-10
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%  change log
%  1 20250305 kj
%   change vecc/vecs into column vector
%**************************************************************************
ntime=length(shc);
if ntime>1
error('more than one shc');
end

loc=0;
for n=0:maxn
    for m=0:n
        loc=loc+1;
        nm(loc,1)=n;
        nm(loc,2)=m;
    end
end
nlength=size(nm,1);
% sometimes we donot need all sh
vecc=shc.cnm(1:nlength);
vecc=vecc(:);

vecs=shc.snm(1:nlength);
vecs=vecs(:);

end

function [clm]=storage_shc2clm(shc,maxn)                               
%  [clm]=storage_shc2clm(shc,maxn)      
%----------------------------------------------------------------------------
% In   :    shc     [struct{cnm;snm}]
%                   a structure storages values of c and s
%                   (stored as degree-leading format) in its subfield
%                   shc.cnm and shc.snm, respectively.
%           maxn     [1x1] maximum degree
% Out  :
%    clm ............ matrix   [en x 4] 
%                               coefficients in clm-format ([n; m; cnm; snm] )  
%    nontion:
%                   Lmax means maximum degree; tt means the length of shc
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
%   1 20250305 kj
%   must combinate the column vector
%**************************************************************************
ntime=length(shc);
if ntime>1
    error('more than one shc');
end

[nn,mm]=get_nnmm(maxn);
clm=[nn mm shc.cnm(:) shc.snm(:)]; %modify by kj 20250305
                  
                              
                              
end


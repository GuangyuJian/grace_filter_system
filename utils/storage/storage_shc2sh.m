function [sh]=storage_shc2sh(shc)                               
%[sh]=storage_shc2sh(shc)                                
%----------------------------------------------------------------------------
% In   :    shc     [struct{cnm;snm}]
%                   a structure storages values of c and s
%                   (stored as degree-leading format) in its subfield
%                   shc.cnm and shc.snm, respectively.
%                              
% Out  :    sh      [(maxn+1)*(maxn+2) x 1] 
%                   a column vector storages the  all c and s
%                   e.g.,  
%                   [c00(1); c10(1);...; cLmaxLmax; s00(1); ...;sLmaxLmax]';  
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
ntime=length(shc);
if ntime>1
error('more than one shc');
end

nsh=length(shc(1).cnm);
sh=zeros(nsh*2,1);
sh(:,1)=[shc(1).cnm;shc(1).snm];
end


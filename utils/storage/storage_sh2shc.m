function [shc]=storage_sh2shc(sh)                               
%[sh]=storage_shc2sh(shc)                                
%----------------------------------------------------------------------------
% In  :    sh      [(maxn+1)*(maxn+2) x 1] 
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
% 
% Out   :    shc     [struct{cnm;snm}]
%                   a structure storages values of c and s
%                   (stored as degree-leading format) in its subfield
%                   shc.cnm and shc.snm, respectively.
%                              
%----------------------------------------------------------------------------
                                                           
                              
% Authors: Karl Jian (K.J)
% address: Sun Yat-sen University   (SYSU)
% email: jiangy336@mail2.sysu.edu.cn
% supervisor: Prof. Min Zhong
%----------------------------------------------------------------------------
%test file: test_                       
%----------------------------------------------------------------------------
                              
loc1=size(sh,1)/2;
shc(1).cnm=sh(1:loc1,:);
shc(1).snm=sh(1+loc1:end,:);
                              
end


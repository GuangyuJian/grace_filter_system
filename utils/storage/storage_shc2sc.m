function [sc]=storage_shc2sc(shc,maxn)                     
%                              
%----------------------------------------------------------------------------
% In   :    
%                              
% Out  :    
%                              
%----------------------------------------------------------------------------
                              
                              
% Authors: Karl Jian (K.J)
% address: Sun Yat-sen University   (SYSU)
% email: jiangy336@mail2.sysu.edu.cn
% supervisor: Prof. Min Zhong
%----------------------------------------------------------------------------
%test file: test_                       
%----------------------------------------------------------------------------
ntime=length(shc);
if ntime>1
error('more than one shc');
end                      

[clm]=storage_shc2clm(shc,maxn);
[sc ]=storage_clm2sc (clm,maxn);
                                                          
end


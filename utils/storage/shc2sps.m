function [sps]=shc2sps(shc,maxn)                               
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
[sc]=storage_shc2sc(shc,maxn);                             
nlist=1;
sps=sqrt(sum(sc.^2,2)./nlist(:));                           
                              
end


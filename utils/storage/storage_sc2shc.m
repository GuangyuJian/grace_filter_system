function [shc]=storage_sc2shc(sc)                               
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
                              
cs   =storage_sc2cs(sc);
[shc]=storage_cs2shc(cs);                              
                              
end


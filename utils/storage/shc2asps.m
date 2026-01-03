function [asps]=shc2asps(shc,maxn)
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

[sps]=shc2sps(shc,maxn);
asps=nan(maxn+1,1);

for nn=2:maxn
    asps(nn+1)=sqrt(sum(sps(3:nn+1).^2,'all'));
end


end


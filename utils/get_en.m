function en = get_en(maxn)
% GET_EN Calculate number of coefficients in clm format
% en = 1 + (maxn+3)*maxn/2
%
% Input:
%   maxn - Maximum degree
% Output:
%   en   - Number of coefficients

en = 1 + (maxn+3)*maxn/2;
end
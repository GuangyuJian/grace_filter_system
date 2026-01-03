classdef HanFilter < BaseFilter
    % HANFILTER Han anisotropic filter
    
    properties (Constant)
        name = 'Han Filter'
        description = 'Han non-isotropic filter with radius varying with order'
    end
    
    properties
        r0 = 500            % Parameter r0 (km)
        r1 = 1000           % Parameter r1 (km)
        m1 = 15             % Parameter m1
    end
    
    methods
        function obj = HanFilter(maxn, r0, r1, m1)
            % Constructor
            % HanFilter(maxn) - With default parameters
            % HanFilter(maxn, r0, r1, m1) - With custom parameters
            
            obj@BaseFilter(maxn);
            
            if nargin >= 2
                obj.r0 = r0;
            end
            if nargin >= 3
                obj.r1 = r1;
            end
            if nargin >= 4
                obj.m1 = m1;
            end
        end
        
        function wnm = computeWeights(obj)
            % Compute Han filter weights
            % Radius varies linearly with order: r(m) = (r1 - r0)/m1 * m + r0
            
            en = get_en(obj.maxn);
            wnm = zeros(en, 1);
            
            for n = 0:obj.maxn
                st = 2 + (n+2)*(n-1)/2;
                for m = 0:n
                    % Calculate radius for this order
                    r_m = (obj.r1 - obj.r0) / obj.m1 * m + obj.r0;
                    
                    % Calculate weight
                    wnm(st+m) = exp(-(n * r_m / obj.earth_radius)^2 / (4 * log(2)));
                end
            end
        end
        
    end
end
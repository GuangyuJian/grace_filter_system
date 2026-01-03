classdef FanFilter < BaseFilter
    % FANFILTER Fan filter (anisotropic)
    
    properties (Constant)
        name = 'Fan Filter'
        description = 'Anisotropic fan filter with different smoothing in degree and order'
    end
    
    properties
        radius = 300        % Filter radius (km)
    end
    
    methods
        function obj = FanFilter(maxn, radius)
            % Constructor
            % FanFilter(maxn, radius) - Create fan filter
            
            obj@BaseFilter(maxn);
            
            if nargin >= 2
                obj.radius = radius;
            end
        end
        
        function wnm = computeWeights(obj)
            % Compute fan filter weights
            % Returns: wnm - weight coefficients in clm format
            
            en = get_en(obj.maxn);
            wnm = zeros(en, 1);
            
            % Precompute degree and order weights
            wn = zeros(1, obj.maxn+1);
%             wm = zeros(1, obj.maxn+1);
            
            for n = 0:obj.maxn
                % Same weight for degree and order in standard fan filter
                weight = exp(-(n * obj.radius / obj.earth_radius)^2 / (4 * log(2)));
                wn(n+1) = weight;
%                 wm(n+1) = weight;
            end
            
            % Combine weights: wnm = wn * wm
            for n = 0:obj.maxn
                st = 2 + (n+2)*(n-1)/2;
                for m = 0:n
                    wnm(st+m) = wn(n+1) * wn(m+1);
                end
            end
        end
        
    end
end



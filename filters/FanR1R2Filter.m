classdef FanR1R2Filter < BaseFilter
    % FANR1R2FILTER Dual-radius fan filter
    
    properties (Constant)
        name = 'Dual-Radius Fan Filter'
        description = 'Fan filter with different radii for degree and order'
    end
    
    properties
        radius_degree = 300     % Radius for degree smoothing (km)
        radius_order = 500      % Radius for order smoothing (km)
    end
    
    methods
        function obj = FanR1R2Filter(maxn, radius_degree, radius_order)
            % Constructor
            % FanR1R2Filter(maxn, radius_degree, radius_order)
            
            obj@BaseFilter(maxn);
            
            if nargin >= 2
                obj.radius_degree = radius_degree;
            end
            if nargin >= 3
                obj.radius_order = radius_order;
            end
        end
        
        function wnm = computeWeights(obj)
            % Compute dual-radius fan filter weights
            
            en = get_en(obj.maxn);
            wnm = zeros(en, 1);
            
            % Precompute degree and order weights with different radii
            wn = zeros(1, obj.maxn+1);
            wm = zeros(1, obj.maxn+1);
            
            for n = 0:obj.maxn
                % Degree weights with radius_degree
                wn(n+1) = exp(-(n * obj.radius_degree / obj.earth_radius)^2 / (4 * log(2)));
                
                % Order weights with radius_order
                wm(n+1) = exp(-(n * obj.radius_order / obj.earth_radius)^2 / (4 * log(2)));
            end
            
            % Combine weights
            for n = 0:obj.maxn
                st = 2 + (n+2)*(n-1)/2;
                for m = 0:n
                    wnm(st+m) = wn(n+1) * wm(m+1);
                end
            end
        end
        
       
    end
end
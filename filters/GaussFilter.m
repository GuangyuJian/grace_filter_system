classdef GaussFilter < BaseFilter
    % GAUSSFILTER Gaussian spatial filter
    
    properties (Constant)
        name = 'Gaussian Filter'
        description = 'Isotropic Gaussian filter for spatial smoothing'
    end
    
    properties
        radius = 300        % Filter radius (km)
    end
    
    methods
        function obj = GaussFilter(maxn, radius)
            % Constructor
            % GaussFilter(maxn, radius) - Create Gaussian filter
            
            obj@BaseFilter(maxn);
            
            if nargin >= 2
                obj.radius = radius;
            end
        end
        
        function wnm = computeWeights(obj)
            % Compute Gaussian weights
            % Returns: wnm - weight coefficients in clm format
            
            en = get_en(obj.maxn);
            wnm = zeros(en, 1);
            
            % Calculate weights for each degree
            for n = 0:obj.maxn
                % Gaussian weight formula
                wn = exp(-(n * obj.radius / obj.earth_radius)^2 / (4 * log(2)));
                
                % Apply to all orders for this degree
                st = 2 + (n+2)*(n-1)/2;
                wnm(st:st+n) = wn;
            end
        end
      
        
        function  set.radius(obj, value)
            % Set radius with validation
            if value <= 0
                error('Radius must be positive');
            end
            obj.radius = value;
        end
    end
end
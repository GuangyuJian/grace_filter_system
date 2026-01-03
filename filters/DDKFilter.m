classdef DDKFilter < BaseFilter
    % DDKFILTER DDK filter for GRACE data destriping and decorrelation
    
    properties (Constant)
        name = 'DDK Filter'
        description = 'DDK filter for GRACE data destriping and decorrelation'
    end
    
    properties
        ddkType = 5         % DDK type: 1-8 (1=strongest, 8=weakest)
    end
    
    methods
        function obj = DDKFilter(maxn, ddkType)
            % Constructor
            % DDKFilter(maxn) - Default DDK5
            % DDKFilter(maxn, ddkType) - Specific DDK type
            
            if nargin >= 1
                obj.maxn = maxn;
            end
            if nargin >= 2
                if ddkType < 1 || ddkType > 8
                    error('DDKFilter:InvalidType', ...
                        'DDK type must be between 1 and 8');
                end
                obj.ddkType = ddkType;
            end
        end
        
        function wnm = computeWeights(obj)
            % COMPUTEWEIGHTS Compute DDK filter weights
            % Note: DDK uses specialized algorithm, returns unity weights
%             en = get_en(obj.maxn);
%             wnm = ones(en, 1);
        end
        
        function shc_out = applyTo(obj, shc_in)
            % APPLYTO Apply DDK destriping filter
            
            
            % Get SH coefficients
            if isa(shc_in, 'sol_shc')
                maxn = shc_in.maxn;
                shc = shc_in.storage;
            elseif isa(shc_in, 'struct')
                maxn = obj.maxn;
                shc = shc_in;
            end
            
            % Convert to DDK format
            shc_ddk = storage_shct2ddk(shc, maxn);
            % Apply DDK filtering
            dataDDK = gmt_destriping_ddk(obj.ddkType, shc_ddk);
            % Convert back to SHC format
           shc = storage_ddk2shct(dataDDK);
            if isa(shc_in, 'sol_shc')
                shc_out=shc_in.copy();
                shc_out.storage=shc;
            elseif isa(shc_in, 'struct')
                shc_out=shc;
            end
        end
        
        function newObj = copy(obj)
            % COPY Create a copy of the DDK filter
            newObj = DDKFilter(obj.maxn, obj.ddkType);
        end
    end
    

end
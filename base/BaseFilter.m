classdef BaseFilter < handle & matlab.mixin.Heterogeneous
    % BASEFILTER Base class for all spatial filters

    properties
        % Basic properties
        maxn = 60               % Maximum degree
        earth_radius = 6371     % Earth radius (km)

        % Filter parameters
        parameters = struct()   % Parameter structure
    end

    properties (Abstract, Constant)
        name                    % Filter name
        description             % Filter description
    end

    methods (Abstract)
        % Calculate weight coefficients
        wnm = computeWeights(obj)

    end

    methods
        function obj = BaseFilter(maxn, varargin)
            % Constructor
            % BaseFilter(maxn) - Create filter with specified max degree
            % BaseFilter(maxn, param1, value1, ...) - With parameters

            if nargin > 0
                obj.maxn = maxn;
            end

            % Parse additional parameters
            if mod(length(varargin), 2) == 0
                for i = 1:2:length(varargin)
                    obj.parameters.(varargin{i}) = varargin{i+1};
                end
            end
        end

        function shc_out = applyTo(obj, shc_in)
            % APPLYTO Default implementation - apply weights directly
            % Most filters can use this default implementation
            %

            wnm = obj.computeWeights();
            en = length(wnm);

            switch class(shc_in)

                case 'struct'
                    shc_out = shc_in;
                    for t = 1:length(shc_in)
                        shc_out(t).cnm(1:en) = shc_in(t).cnm(1:en) .* wnm;
                        shc_out(t).snm(1:en) = shc_in(t).snm(1:en) .* wnm;
                    end
                case 'sol_shc'

                    shc_out = shc_in.copy();
                    % Ensure gc format
                    shc_out.change_type('gc');
                    shc = shc_out.storage;

                    % Apply weights
                    for t = 1:length(shc)
                        shc(t).cnm(1:en) = shc(t).cnm(1:en) .* wnm;
                        shc(t).snm(1:en) = shc(t).snm(1:en) .* wnm;
                    end
                    shc_out.storage = shc;
                otherwise
                    error('invaild input')

            end

        end
    end
end
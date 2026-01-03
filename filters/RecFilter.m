classdef RecFilter < BaseFilter
    % RECFILTER Reconstructed filter for signal enhancement

    properties (Constant)
        name = 'Reconstructed Filter'
        description = 'Reconstructed filter for signal enhancement'
    end

    properties
        baseFilter           % Base filter object
        iterations = 3       % Number of iterations (N)
        reconstruction_mode = 1  % s=0: backward, s=1: forward
    end

    methods
        function obj = RecFilter(baseFilter, iterations, mode)
            % Constructor
            % RecFilter(baseFilter) - Default: 3 iterations, forward mode
            % RecFilter(baseFilter, iterations) - Custom iterations
            % RecFilter(baseFilter, iterations, mode) - With mode specification

            obj@BaseFilter(baseFilter.maxn);
            obj.baseFilter = baseFilter;
            obj.earth_radius = baseFilter.earth_radius;

            if nargin >= 2
                if iterations < 1
                    error('RecFilter:InvalidIterations', ...
                        'Iterations must be at least 1');
                end
                obj.iterations = iterations;
            end

            if nargin >= 3
                if ~(mode == 0 || mode == 1)
                    error('RecFilter:InvalidMode', ...
                        'Mode must be 0 (backward) or 1 (forward)');
                end
                obj.reconstruction_mode = mode;
            end
        end

        function wnm = computeWeights(obj)
            % COMPUTEWEIGHTS Compute reconstructed filter weights
            % Formula: W_s^N = (1-δ_s0)W^N + δ_s0(1-(1-W)^N)
            % where: δ_s0 is Kronecker delta
            %        s=0: backward reconstruction
            %        s=1: forward reconstruction
            %        N: number of iterations
            %        W: base filter weights

            base_wnm = obj.baseFilter.computeWeights();

            % Kronecker delta: δ_s0
            delta_s0 = double(obj.reconstruction_mode == 1);

            % Apply reconstruction formula
            if delta_s0 == 1
                % Backward reconstruction: s = 0
                % W_0^N = W^N
                wnm = base_wnm.^obj.iterations;
            else
                % Forward reconstruction: s = 1
                % W_1^N = 1 - (1 - W)^N
                wnm = 1 - (1 - base_wnm).^obj.iterations;
            end


        end

        function shc_out = applyTo(obj, shc_in)
            % APPLYTO Apply reconstructed filter
            % Uses base class applyTo if base filter is Gauss or Fan
            % Otherwise needs custom implementation

            % Check if base filter is GaussFilter or FanFilter
            baseClass = class(obj.baseFilter);

            switch baseClass

                case  {'GaussFilter','FanR1R2Filter','FanFilter','HanFilter'}
                    % Use base class applyTo (default implementation)
                    shc_out = applyTo@BaseFilter(obj, shc_in);
                case  {'DDKFilter'}
                    % Base filter has custom applyTo (e.g., DDKFilter, another RecFilter)
                    % We need to compute weights first, then apply
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
                    % Apply reconstructed DDK filtering
                    dataDDK = obj.applyRecDDKFiltering(shc_ddk);
                    % Convert back to SHC format
                    shc = storage_ddk2shct(dataDDK);
                    if isa(shc_in, 'sol_shc')
                        shc_out=shc_in.copy();
                        shc_out.storage=shc;
                    elseif isa(shc_in, 'struct')
                        shc_out=shc;
                    end
                otherwise
                    error('RecFilter:InvalidInput', 'Invalid input type');
            end
        end


        function newObj = copy(obj)
            % COPY Create a copy of the filter
            newObj = RecFilter(obj.baseFilter.copy(), ...
                obj.iterations, ...
                obj.reconstruction_mode);
        end

    end

    methods (Access = private)
        function dataDDK = applyRecDDKFiltering(obj, data)
            % APPLYRECDDKFILTERING Main DDK reconstruction algorithm

            % Get DDK type description
            switch obj.baseFilter.ddkType
                case 1  % strongest DDK1
                    file = 'Wbd_2-120.a_1d14p_4';
                case 2  % DDK2
                    file = 'Wbd_2-120.a_1d13p_4';
                case 3  % DDK3
                    file = 'Wbd_2-120.a_1d12p_4';
                case 4  % DDK4
                    file = 'Wbd_2-120.a_5d11p_4';
                case 5  % DDK5
                    file = 'Wbd_2-120.a_1d11p_4';
                case 6
                    file = 'Wbd_2-120.a_5d10p_4';
                case 7
                    file = 'Wbd_2-120.a_1d10p_4';
                case 8
                    file = 'Wbd_2-120.a_5d9p_4';
                otherwise
                    error('RecDDKFilter:InvalidType', ...
                        'DDK type must be between 1 and 8');
            end

            % Read filter coefficients
            dat = read_BIN(file);

            % Extract block information
            nblocks = dat.nblocks;
            blockind = dat.blockind;

            % Initialize block size arrays
            sz = zeros(1, nblocks);
            nstart = zeros(1, nblocks);
            nend = zeros(1, nblocks);

            % First block
            sz(1) = blockind(1);
            nstart(1) = 1;
            nend(1) = 1 + sz(1)^2 - 1;

            % Remaining blocks
            for ij = 2:nblocks
                sz(ij) = blockind(ij) - blockind(ij-1);
                nstart(ij) = 1 + sum(sz(1:ij-1).^2);
                nend(ij) = nstart(ij) + sz(ij).^2 - 1;
            end

            % Get data dimensions
            nmax = size(data.C, 1) - 1;
            ntime = size(data.C, 3);

            % Initialize output
            dataDDK = data;

            % Process order 0
            ordre = 0;
            ij = ordre + 1;
            block = reshape(dat.pack1(nstart(ij):nend(ij)), sz(ij), sz(ij));
            block = block(1:nmax-1, 1:nmax-1);

            % Apply reconstruction
            if obj.reconstruction_mode == 1  % forward
                FC = obj.computeForwardReconstructedMatrix(block, obj.iterations);
            else  % backward
                FC = obj.computeBackwardReconstructedMatrix(block, obj.iterations);
            end

            % Apply to all time steps
            for klm = 1:ntime
                coef = squeeze(data.C(3:end, ordre+1, klm));
                dataDDK.C(3:end, ij, klm) = FC * coef;
            end

            % Process higher orders
            ordre = 1;
            while ordre < nmax + 1
                % Cosine and sine block indices
                ij_cos = 2 * ordre;
                ij_sin = ij_cos + 1;

                % Check if blocks exist
                if ij_cos <= nblocks && ij_sin <= nblocks
                    % Extract cosine and sine blocks
                    blockC = reshape(dat.pack1(nstart(ij_cos):nend(ij_cos)), ...
                        sz(ij_cos), sz(ij_cos));
                    blockS = reshape(dat.pack1(nstart(ij_sin):nend(ij_sin)), ...
                        sz(ij_sin), sz(ij_sin));

                    % Truncate to available degrees
                    fin = min(nmax-1, nmax-ordre+1);
                    blockC = blockC(1:fin, 1:fin);
                    blockS = blockS(1:fin, 1:fin);

                    % Starting degree for this order
                    deb = max(3, ordre+1);

                    % Apply reconstruction
                    if obj.reconstruction_mode == 1  % forward
                        FC = obj.computeForwardReconstructedMatrix(blockC, obj.iterations);
                        FS = obj.computeForwardReconstructedMatrix(blockS, obj.iterations);
                    else  % backward
                        FC = obj.computeBackwardReconstructedMatrix(blockC, obj.iterations);
                        FS = obj.computeBackwardReconstructedMatrix(blockS, obj.iterations);
                    end

                    % Apply to all time steps
                    for klm = 1:ntime
                        coefC = squeeze(data.C(deb:end, ordre+1, klm));
                        coefS = squeeze(data.S(deb:end, ordre+1, klm));

                        dataDDK.C(deb:end, ordre+1, klm) = FC * coefC;
                        dataDDK.S(deb:end, ordre+1, klm) = FS * coefS;
                    end
                end

                ordre = ordre + 1;
            end
        end

        function F = computeBackwardReconstructedMatrix(~, W, power)
            % COMPUTEBACKWARDRECONSTRUCTEDMATRIX Compute backward reconstructed matrix
            % Formula: W_N^0 = 1 - (1-W)^N

            Im = eye(size(W));
            [V, D] = eig(W);

            eigVal = diag(D);
            eigValPower = (1 - eigVal).^power;

            F = Im - V * diag(eigValPower) / V;
        end

        function F = computeForwardReconstructedMatrix(~, W, power)
            % COMPUTEFORWARDRECONSTRUCTEDMATRIX Compute forward reconstructed matrix
            % Formula: W_N^1 = W^N

            [V, D] = eig(W);

            eigVal = diag(D);
            eigValPower = eigVal.^power;

            F = V * diag(eigValPower) / V;
        end
    end
end
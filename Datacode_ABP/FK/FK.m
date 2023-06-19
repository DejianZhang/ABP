function vol = FK(meas, tofgrid, wall_size, crop, bin_resolution)


% Load scene & set visualization parameter

    % Constants
    c = 3e8;    % Speed of light (meters per second)
    width = wall_size / 2;
    if ~exist('crop', 'var') % bin index to crop measurements after aligning
        crop = 512;          % so that direct component is at t=0
    end
    if ~exist('bin_resolution', 'var')
       bin_resolution = 32e-12; % temporal bin resolution of measurements 
    end
    

    % adjust so that t=0 is when light reaches the scan surface
    if ~isempty(tofgrid)
        for ii = 1:size(meas, 1)
            for jj = 1:size(meas,2 )
                meas(ii, jj, :) = circshift(meas(ii, jj, :), [0, 0, -floor(tofgrid(ii, jj) / (bin_resolution*1e12))]);
            end
        end  
    end
    meas = meas(:, :, 1:crop);
    
    N = size(meas,1);        % Spatial resolution of data
    M = size(meas,3);        % Temporal resolution of data
    range = M.*c.*bin_resolution; % Maximum range for histogram
    
    % Permute data dimensions
    data = permute(meas,[3 2 1]);

    % Define volume representing voxel distance from wall
    grid_z = repmat(linspace(0,1,M)',[1 N N]);

    display('Inverting...');
    tic;


    [z,y,x] = ndgrid(-M:M-1,-N:N-1,-N:N-1);
    z = z./M; y = y./N; x = x./N;

    % Step 0: Pad data
    data = data .* grid_z.^2;
    data = sqrt(data);
    tdata = zeros(2.*M,2.*N,2.*N);
    tdata(1:end./2,1:end./2,1:end./2) = data;

    % Step 1: FFT
    tdata = fftshift(fftn(tdata));

    % Step 2: Stolt trick
    tvol = interpn(z,y,x,tdata,sqrt(abs((((N.*range)./(M.*width.*4)).^2).*(x.^2+y.^2)+z.^2)),y,x,'linear',0);
    tvol = tvol.*(z > 0);
    tvol = tvol.*abs(z)./max(sqrt(abs((((N.*range)./(M.*width.*4)).^2).*(x.^2+y.^2)+z.^2)),1e-6);

    % Step 3: IFFT
    tvol = ifftn(ifftshift(tvol));
    tvol = abs(tvol).^2;    
    vol = abs(tvol(1:end./2,1:end./2,1:end./2));

    

    display('... done.');
    time_elapsed = toc;

    display(sprintf(['Reconstructed volume of size %d x %d x %d '...
        'in %f seconds'], size(vol,3),size(vol,2),size(vol,1),time_elapsed));

    tic_z = linspace(0,range./2,size(vol,1));
    tic_y = linspace(width,-width,size(vol,2));
    tic_x = linspace(width,-width,size(vol,3));

    % clip artifacts at boundary, rearrange for visualization
    vol(end-10:end, :, :) = 0;


    vol = permute(vol,[3 2 1]);
  

end

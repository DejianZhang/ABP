function vol = BP_LCT(tof_data)

load color
% Constants
c              = 3e8;   % Speed of light (meters per second)

% Adjustable parameters
isbackprop = 1;         % Toggle backprojection
isdiffuse  = 0;         % Toggle diffuse reflection
K          = 2;         % Downsample data to (4 ps) * 2^K = 16 ps for K = 2
snr        = 0.1;         % SNR value
z_trim     = 0;       % Set first 500 bins to zero
width = 1;

% Load scene & set visualization parameter

rect_data = double(tof_data);
bin_resolution = 32e-12;  
z_offset =0;
        


N = size(rect_data,1);        % Spatial resolution of data
M = size(rect_data,3);        % Temporal resolution of data
range = M.*c.*bin_resolution; % Maximum range for histogram
    
% Downsample data to 16 picoseconds
% for k = 1:K
%     M = M./2;
%     bin_resolution = 2*bin_resolution;
%     rect_data = rect_data(:,:,1:2:end) + rect_data(:,:,2:2:end);
%     z_trim = round(z_trim./2);
%     z_offset = round(z_offset./2);
% end
    
% Set first group of histogram bins to zero (to remove direct component)
rect_data(:,:,1:z_trim) = 0;
    
% Define NLOS blur kernel 
psf = definePsf(N,M,width./range);

% Compute inverse filter of NLOS blur kernel
fpsf = fftn(psf);
if (~isbackprop)
    invpsf = conj(fpsf) ./ (abs(fpsf).^2 + 1./snr);
else
    invpsf = conj(fpsf);
end

% Define transform operators
[mtx,mtxi] = resamplingOperator(M);

% Permute data dimensions
data = permute(rect_data,[3 2 1]);

% Define volume representing voxel distance from wall
grid_z = repmat(linspace(0,1,M)',[1 N N]);

display('Inverting...');
tic;

% Step 1: Scale radiometric component
if (isdiffuse)
    data = data.*(grid_z.^4);
else
    data = data.*(grid_z.^2);
end

% Step 2: Resample time axis and pad result
tdata = zeros(2.*M,2.*N,2.*N);
tdata(1:end./2,1:end./2,1:end./2)  = reshape(mtx*data(:,:),[M N N]);

% Step 3: Convolve with inverse filter and unpad result
tvol = ifftn(fftn(tdata).*invpsf);
tvol = tvol(1:end./2,1:end./2,1:end./2);

% Step 4: Resample depth axis and clamp results
vol  = reshape(mtxi*tvol(:,:),[M N N]);
vol  = max(real(vol),0);





display('... done.');
time_elapsed = toc;

display(sprintf(['Reconstructed volume of size %d x %d x %d '...
    'in %f seconds'], size(vol,3),size(vol,2),size(vol,1),time_elapsed));

tic_z = linspace(0,range./2,size(vol,1));
tic_y = linspace(-width,width,size(vol,2));
tic_x = linspace(-width,width,size(vol,3));

% Crop and flip reconstructed volume for visualization
ind = 512;
vol = vol(:,:,end:-1:1);
vol = vol((1:ind)+z_offset,:,:);

tic_z = tic_z((1:ind)+z_offset);

vol = permute(vol,[2,3,1]);
vol = rot90(vol);


 






function psf = definePsf(U,V,slope)
% Local function to computeD NLOS blur kernel

x = linspace(-1,1,2.*U);
y = linspace(-1,1,2.*U);
z = linspace(0,2,2.*V);
[grid_z,grid_y,grid_x] = ndgrid(z,y,x);

% Define PSF
psf = abs(((4.*slope).^2).*(grid_x.^2 + grid_y.^2) - grid_z);
psf = double(psf == repmat(min(psf,[],1),[2.*V 1 1]));
psf = psf./sum(psf(:,U,U));
psf = psf./norm(psf(:));
psf = circshift(psf,[0 U U]);


function [mtx,mtxi] = resamplingOperator(M)
% Local function that defines resampling operators

mtx = sparse([],[],[],M.^2,M,M.^2);

x = 1:M.^2;
mtx(sub2ind(size(mtx),x,ceil(sqrt(x)))) = 1;
mtx  = spdiags(1./sqrt(x)',0,M.^2,M.^2)*mtx;
mtxi = mtx';

K = log(M)./log(2);
for k = 1:round(K)
    mtx  = 0.5.*(mtx(1:2:end,:)  + mtx(2:2:end,:));
    mtxi = 0.5.*(mtxi(:,1:2:end) + mtxi(:,2:2:end));
end

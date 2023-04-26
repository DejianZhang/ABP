function BP_LCT(scene)
% Confocal Non-Light-of-Sight (C-NLOS) reconstruction procedure for paper
% titled "Confocal Non-Line-of-Sight Imaging Based on the Light Cone Transform"
% by Matthew O'Toole, David B. Lindell, and Gordon Wetzstein.
%
% Function takes as input an integer between 1 and 9, 
% corresponding to the following scenes:
%   1 - Z
%   2 - LT
%   3 - human
%   4 - T

%
%
% The associated .mat data files contain C-NLOS measurements that are
% pre-rectified (i.e., direct component starts at the first time bin) and
% cropped.

% Default scene
if nargin < 1
    scene = 7;
end

% Constants

c              = 3e8;   % Speed of light (meters per second)

% Adjustable parameters
isbackprop = 1;         % Toggle backprojection
isdiffuse  = 0;         % Toggle diffuse reflection
K          = 2;         % Downsample data to (4 ps) * 2^K = 16 ps for K = 2
snr        = 5;         % SNR value
z_trim     = 500;       % Set first 600 bins to zero
width = 0.4;

% Load scene & set visualization parameter
switch scene
    case {1}
        load Z.mat
        bin_resolution = 5e-12;
        rect_data = tof_data;
        z_offset = 100;
    case {2}
        load LT.mat
        bin_resolution = 5e-12;
        rect_data = tof_data;
        z_offset = 100;
    case {3}
        load human.mat
        bin_resolution = 4e-12;
        rect_data = tof_data;
        rect_data = rot90(rect_data);
        z_offset = 600;
    case {4}
        load T.mat
        bin_resolution = 5e-12;
        rect_data = tof_data;
        z_offset =100;
               
        % Because the scene is diffuse, toggle the diffuse flag and 
        % adjust SNR value correspondingly.
        isdiffuse = 1;
        snr = snr.*1e-1;
end

N = size(rect_data,1);        % Spatial resolution of data
M = size(rect_data,3);        % Temporal resolution of data
range = M.*c.*bin_resolution; % Maximum range for histogram
    
% Downsample data to 16 picoseconds
for k = 1:K
    M = M./2;
    bin_resolution = 2*bin_resolution;
    rect_data = rect_data(:,:,1:2:end) + rect_data(:,:,2:2:end);
    z_trim = round(z_trim./2);
    z_offset = round(z_offset./2);
end
    
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
ind = round(M.*2.*width./(range./2));
vol = vol(:,:,end:-1:1);
vol = vol((1:ind)+z_offset,:,:);

tic_z = tic_z((1:ind)+z_offset);

% View result
% vol = permute(vol,[2,3,1]);
load color.mat
figure('pos',[10 10 900 300]);

subplot(1,3,1);
imagesc(tic_x,tic_y,squeeze(max(vol,[],1)));
title('Front view');
set(gca,'XTick',linspace(min(tic_x),max(tic_x),3));
set(gca,'YTick',linspace(min(tic_y),max(tic_y),3));
xlabel('x (m)');
ylabel('y (m)');
colormap(mycolormap);
axis square;

subplot(1,3,2);
imagesc(tic_x,tic_z,squeeze(max(vol,[],2)));
title('Top view');
set(gca,'XTick',linspace(min(tic_x),max(tic_x),3));
set(gca,'YTick',linspace(min(tic_z),max(tic_z),3));
xlabel('x (m)');
ylabel('z (m)');
colormap(mycolormap);
axis square;

subplot(1,3,3);
imagesc(tic_z,tic_y,squeeze(max(vol,[],3))')
title('Side view');
set(gca,'XTick',linspace(min(tic_z),max(tic_z),3));
set(gca,'YTick',linspace(min(tic_y),max(tic_y),3));
xlabel('z (m)');
ylabel('y (m)');
colormap(mycolormap);
axis square;


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

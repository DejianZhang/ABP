% The Dragon180min and Statue180min datasets can be downloaded at the following link
% https://drive.google.com/drive/folders/115td2Vr6NBUpr4WWRpuWvWyylpHvzbSr?usp=sharing
% captured datasets
Path = pwd;
scene = 1;      %choose the scene
if scene == 1   %statue dataset
    datapath = 'vol_diffuse_statue';
    load('statue_tof.mat');
    load('statue180min.mat');
    load('statue_groundtruth.mat')
    load('EBP_statue_data.mat')
    alpha = 0.5;
    gama = 150;
    data_size = [171:270];
elseif scene == 2   %dragon dataset
    datapath = 'vol_glossy_dragon';
    load('dragon_tof.mat');
    load('dragon180min.mat');
    load('dragon_groundtruth.mat')
    load('EBP_dragon_data.mat')
    alpha = 0.6;
    gama = 1700;
    data_size = [251:320];
end



% resize to low resolution to reduce memory requirements
measlr = imresize3d(meas, 64, 64, 2048); % y, x, t
tofgridlr = imresize(tofgrid, [64, 64]); 
wall_size = 2; % scanned area is 2 m x 2 m

% run BP
fprintf('\nRunning BP\n');
algorithm = 1;
BP = cnlos_reconstruction(measlr, tofgridlr, wall_size, algorithm);

% run FBP
fprintf('\nRunning FBP\n');
algorithm = 0;
fbp = cnlos_reconstruction(measlr, tofgridlr, wall_size, algorithm);

% run EBP
fprintf('\nRunning EBP\n');
EBP = EBP3D(tof_data,alpha,gama,data_size);

% run ABP
tic
fprintf('\nRunning ABP\n');
algorithm = 5;
ABP = cnlos_reconstruction(measlr, tofgridlr, wall_size, algorithm);
toc


% run f-k migration
fprintf('\nRunning f-k migration\n');
algorithm = 2;
fk = cnlos_reconstruction(measlr, tofgridlr, wall_size, algorithm);



%%
t = tiledlayout(1,6);
nexttile
load color.mat
imshow(ground_truth);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
title('Ground truth')

nexttile
imagesc(squeeze(max(BP,[],3)));
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
title('BP');
colormap(mycolormap);
axis square;

nexttile
imagesc(squeeze(max(fbp,[],3)));
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
title('FBP');
colormap(mycolormap);
axis square;


nexttile
imagesc(squeeze(max(EBP,[],3)));
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
title('EBP');
colormap(mycolormap);
axis square;

nexttile
imagesc(squeeze(max(ABP,[],3)));
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
title('ABP');
colormap(mycolormap);
axis square;

nexttile
imagesc(squeeze(max(fk,[],3)));
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
title('f-k');
colormap(mycolormap);
axis square;


save_path = strcat(Path,'\data_result\',datapath);
save(save_path,'BP','ABP','EBP','fbp','fk','ground_truth'); 

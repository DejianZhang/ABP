t = tiledlayout(2,6);
load color.mat
load('vol_diffuse_statue.mat')
nexttile
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


load vol_glossy_dragon
nexttile
load color.mat
imshow(ground_truth);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])


nexttile
imagesc(squeeze(max(BP,[],3)));
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
colormap(mycolormap);
axis square;

nexttile
imagesc(squeeze(max(fbp,[],3)));
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
colormap(mycolormap);
axis square;


nexttile
imagesc(squeeze(max(EBP,[],3)));
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
colormap(mycolormap);
axis square;

nexttile
imagesc(squeeze(max(ABP,[],3)));
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
colormap(mycolormap);
axis square;

nexttile
imagesc(squeeze(max(fk,[],3)));
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
colormap(mycolormap);
axis square;
%%
colormap(mycolormap);
t.TileSpacing = 'compact';
t.Padding = 'compact';



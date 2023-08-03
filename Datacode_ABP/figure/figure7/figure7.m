t = tiledlayout(1,4);
%%
load color.mat
load experiment_NCU.mat
%%


%%
%ABP结果
nexttile
imagesc(squeeze(max(vol_ABP_NCU,[],3)));
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])

%N结果
nexttile
imagesc(squeeze(max(vol_ABP_N,[],3)));
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])

%C结果
nexttile
imagesc(squeeze(max(vol_ABP_C,[],3)));
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])

%U结果
nexttile
imagesc(squeeze(max(vol_ABP_U,[],3)));
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])


%%
colormap(mycolormap);
t.TileSpacing = 'compact';
t.Padding = 'compact';



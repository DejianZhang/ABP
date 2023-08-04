t = tiledlayout(2,6);
%%
load color.mat
%%
load experimentZ_result.mat
ground_turth = z;


nexttile%真实物体场景
imshow(ground_turth);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
title('Ground truth')

%反投影结果
nexttile
imagesc(vol_BP_Z);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
title('BP')

nexttile%FBP结果
imagesc(vol_FBP_Z);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
title('FBP')

nexttile%EBP结果
imagesc(vol_EBP_Z);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
title('EBP')

nexttile%ABP结果
imagesc(vol_ABP_Z);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
title('ABP')

nexttile%FK结果
imagesc(vol_FK_Z);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
title('FK')
%%
load experimentLT_result.mat



nexttile%真实物体场景
imshow(T_L);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])

%反投影结果
nexttile
imagesc(vol_BP_LT);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])


nexttile%FBP结果
imagesc(vol_FBP_LT);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])


nexttile%EBP结果
imagesc(vol_EBP_LT);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])

nexttile%ABP结果
imagesc(vol_ABP_LT);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])


nexttile%FK结果
imagesc(vol_FK_LT);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])

%%
colormap(mycolormap);
t.TileSpacing = 'compact';
t.Padding = 'compact';



t = tiledlayout(1,5);
%%
MSE_table = cell(2,5);
MSE_table{1,1} = 'object';
MSE_table{1,2} = 'BP';
MSE_table{1,3} = 'FBP';
MSE_table{1,4} = 'EBP';
MSE_table{1,5} = 'ABP';



load color.mat
%%
load nonconfocal_U.mat


nexttile%真实物体场景
imagesc(ground_turth);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,1} = 'U';
title('Ground truth')

%反投影结果
nexttile
imagesc(vol_BP);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,2} = mse(ground_turth,vol_BP);
title('BP')

nexttile%FBP结果
imagesc(vol_FBP);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,3} = mse(ground_turth,vol_FBP);
title('FBP')

nexttile%EBP结果
imagesc(vol_EBP);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,4} = mse(ground_turth,vol_EBP);
title('EBP')

nexttile%ABP结果
imagesc(vol_ABP);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,5} = mse(ground_turth,vol_ABP);
title('ABP')


%%
colormap(mycolormap);
t.TileSpacing = 'compact';
t.Padding = 'compact';



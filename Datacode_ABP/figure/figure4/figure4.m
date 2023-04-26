t = tiledlayout(2,5);
%%
MSE_table = cell(3,5);
MSE_table{1,1} = 'object';
MSE_table{1,2} = 'BP';
MSE_table{1,3} = 'FBP';
MSE_table{1,4} = 'EBP';
MSE_table{1,5} = 'ABP';
load color.mat
%%
load simuT_result.mat
ground_turth = zone;


nexttile%真实物体场景
imagesc(ground_turth);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,1} = 'T';
title('Ground truth')

%反投影结果
nexttile
imagesc(vol_BP_T);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,2} = mse(ground_turth,vol_BP_T);
title('BP')

nexttile%FBP结果
imagesc(vol_FBP_T);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,3} = mse(ground_turth,vol_FBP_T);
title('FBP')

nexttile%EBP结果
imagesc(vol_EBP_T);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,4} = mse(ground_turth,vol_EBP_T);
title('EBP')

nexttile%ABP结果
imagesc(vol_ABP_T);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,5} = mse(ground_turth,vol_ABP_T);
title('ABP')


%%
load simuhuman_result.mat
ground_turth = original_zone;


nexttile%真实物体场景
imagesc(ground_turth);
ground_turth = zone;
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{3,1} = 'human';

%反投影结果
nexttile
imagesc(vol_BP_human);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{3,2} = mse(ground_turth,vol_BP_human);

nexttile%FBP结果
imagesc(vol_FBP_human);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{3,3} = mse(ground_turth,vol_FBP_human);

nexttile%EBP结果
imagesc(vol_EBP_human);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{3,4} = mse(ground_turth,vol_EBP_human);

nexttile%ABP结果
imagesc(vol_ABP_human);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{3,5} = mse(ground_turth,vol_ABP_human);


%%
colormap(mycolormap);
t.TileSpacing = 'compact';
t.Padding = 'compact';



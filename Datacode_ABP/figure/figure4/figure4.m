t = tiledlayout(2,6);
%%
MSE_table = cell(3,6);
MSE_table{1,1} = 'object';
MSE_table{1,2} = 'BP';
MSE_table{1,3} = 'FBP';
MSE_table{1,4} = 'EBP';
MSE_table{1,5} = 'ABP';
MSE_table{1,6} = 'FK';


load color.mat
%%
load Lambertian_T.mat
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
imagesc(vol_BP_Lambertian_T);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,2} = mse(ground_turth,vol_BP_Lambertian_T);
title('BP')

nexttile%FBP结果
imagesc(vol_FBP_Lambertian_T);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,3} = mse(ground_turth,vol_FBP_Lambertian_T);
title('FBP')

nexttile%EBP结果
imagesc(vol_EBP_Lambertian_T);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,4} = mse(ground_turth,vol_EBP_Lambertian_T);
title('EBP')

nexttile%ABP结果
imagesc(vol_ABP_Lambertian_T);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,5} = mse(ground_turth,vol_ABP_Lambertian_T);
title('ABP')

nexttile%FK结果
imagesc(vol_FK_Lambertian_T);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{2,6} = mse(ground_turth,vol_FK_Lambertian_T);
title('FK')


%%
load Lambertian_human.mat
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
imagesc(vol_BP_Lambertian_human);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{3,2} = mse(ground_turth,vol_BP_Lambertian_human);

nexttile%FBP结果
imagesc(vol_FBP_Lambertian_human);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{3,3} = mse(ground_turth,vol_FBP_Lambertian_human);

nexttile%EBP结果
imagesc(vol_EBP_Lambertian_human);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{3,4} = mse(ground_turth,vol_EBP_Lambertian_human);

nexttile%ABP结果
imagesc(vol_ABP_Lambertian_human);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{3,5} = mse(ground_turth,vol_ABP_Lambertian_human);

nexttile%FK结果
imagesc(vol_FK_Lambertian_human);
axis square;
set(gca,'xtick',[],'xticklabel',[])
set(gca,'ytick',[],'yticklabel',[])
MSE_table{3,6} = mse(ground_turth,vol_FK_Lambertian_human);


%%
colormap(mycolormap);
t.TileSpacing = 'compact';
t.Padding = 'compact';



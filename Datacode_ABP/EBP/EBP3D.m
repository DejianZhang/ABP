function vol_EBP_human = EBP3D
load human_BP_data.mat
load tof_data_delta.mat
vol_error = BP3D(tof_data_delta,666:1:765,100);


vol_error = vol_error./max(vol_error(:));
vol_error = squeeze(max(vol_error,[],3));

vol_BP = vol_BP./max(vol_BP(:));
vol_BP = squeeze(max(vol_BP,[],3));

vol_EBP = vol_BP - 0.8*vol_error;

vol_EBP_human = squeeze(max(vol_EBP,[],3));
vol_EBP_human = vol_EBP_human - min(vol_EBP_human(:));
vol_EBP_human = vol_EBP_human./max(vol_EBP_human(:));


load color.mat
subplot(1,3,1);
imagesc(squeeze(max(vol_EBP_human,[],3)));
colormap(mycolormap);
axis square;

subplot(1,3,2);
imagesc(squeeze(max(vol_BP,[],3)));
colormap(mycolormap);
axis square;

subplot(1,3,3);
imagesc(squeeze(max(vol_error,[],3)));
colormap(mycolormap);
axis square;

end
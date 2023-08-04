function vol = EBP3D(tof_data,alpha,gama)
vol_BP = BP_LCT(tof_data,5e-12);

tof_data_delta =tof3D(vol_BP,25:1:291,267);
tof_data_delta = rot90(tof_data_delta);

tof_data_delta = tof_data_delta/gama - tof_data ;

vol_error = BP_LCT(tof_data_delta,5e-12);


vol_error = vol_error./max(vol_error(:));
vol_error = squeeze(max(vol_error,[],3));

vol_BP = vol_BP./max(vol_BP(:));
vol_BP = squeeze(max(vol_BP,[],3));

vol_EBP = vol_BP - alpha*vol_error;

vol = squeeze(max(vol_EBP,[],3));
vol = vol - min(vol(:));
vol = vol./max(vol(:));


load color.mat
figure
imagesc(squeeze(max(vol,[],3)));
colormap(mycolormap);
axis square;



end
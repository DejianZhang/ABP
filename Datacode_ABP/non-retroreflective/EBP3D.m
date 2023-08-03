function vol_EBP = EBP3D(tof_data,alpha,gama,data_size)
tof_data = double(tof_data);
BP = BP_LCT(tof_data);
BP = BP(:,:,data_size);

tof_data_delta =tof3D(BP,data_size,data_size(1,end) - data_size(1,1) + 1);


tof_data_delta = tof_data_delta/gama - tof_data ;

vol_error = BP_LCT(tof_data_delta);
vol_error = vol_error(:,:,data_size);

vol_error = vol_error./max(vol_error(:));
vol_error = squeeze(max(vol_error,[],3));

BP = BP./max(BP(:));
BP = squeeze(max(BP,[],3));

vol_EBP = BP - alpha*vol_error;



end
function vol = EBP(tof_data,vol_BP,alpha)

vol_BP = vol_BP./max(vol_BP(:));
tof_data_delta =tof3D(vol_BP,[301:350],50);
tof_data_delta = tof_data_delta - tof_data;

vol_error = ncBP(tof_data_delta,[301:350],50,32,32);

vol_error = vol_error./max(vol_error(:));
vol_error = squeeze(max(vol_error,[],3));

vol_BP = vol_BP./max(vol_BP(:));
vol_BP = squeeze(max(vol_BP,[],3));

vol_EBP = vol_BP - alpha*vol_error;

vol = squeeze(max(vol_EBP,[],3));
vol = vol - min(vol(:));
vol = vol./max(vol(:));






end
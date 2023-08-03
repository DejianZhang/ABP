function vol_FBP = FBP(vol_BP)
vol_BP = vol_BP./max(vol_BP(:));
vol_FBP = filterLaplacian(vol_BP);
vol_BP = max(vol_BP./max(vol_BP(:)),0);
vol_BP = abs(vol_BP);
vol_FBP(:,:,1) = 0;
vol_FBP(:,:,end) = 0;
sanshitu_rotate(vol_FBP);
end
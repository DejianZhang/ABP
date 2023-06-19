function reconstruction_ncBP

% Load scene & set visualization parameterz
Path = pwd;
ground_turth_U;
load simulation_Lamber_U
vol_BP = ncBP(tof_data,[301:350],50,32,32);
vol_FBP = filterLaplacian(vol_BP);  
vol_EBP = EBP(tof_data,vol_BP,0.7);
vol_ABP = ABP(vol_BP);
% View result
load color.mat
figure
subplot(1,5,1);
imshow(ground_turth);

subplot(1,5,2);
vol_BP=squeeze(max(vol_BP,[],3));
vol_BP=(vol_BP/max(max(vol_BP)));
imagesc(vol_BP);%
colormap(mycolormap);
axis square;

subplot(1,5,3);
vol_FBP=squeeze(max(vol_FBP,[],3));
vol_FBP(vol_FBP<0)=0;
vol_FBP=(vol_FBP/max(max(vol_FBP)));     
imagesc(vol_FBP);%
colormap(mycolormap);
axis square;

subplot(1,5,4);
vol_EBP=squeeze(max(vol_EBP,[],3));
vol_EBP=(vol_EBP/max(max(vol_EBP)));
imagesc(vol_EBP);%
colormap(mycolormap);
axis square;

subplot(1,5,5);
vol_ABP=squeeze(max(vol_ABP,[],3));
vol_ABP=(vol_ABP/max(max(vol_ABP)));
imagesc(vol_ABP);%
colormap(mycolormap);
axis square;
save_path = strcat(Path,'\data_result\simulation_U');
save(save_path,'vol_BP','vol_FBP','vol_ABP','vol_EBP');  
end

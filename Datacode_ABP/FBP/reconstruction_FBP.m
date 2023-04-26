function reconstruction_FBP(scene)
%   1 - Z
%   2 - LT
%   3 - human
%   4 - T
% Load scene & set visualization parameter
switch scene
    case {1}
        load Z_BP_data.mat
        vol_BP = vol_BP./max(vol_BP(:));
        vol_FBP = filterLaplacian(vol_BP);
        vol_FBP = max(vol_FBP./max(vol_FBP(:)),0); 
        vol_FBP(:,:,1) = 0;
        vol_FBP(:,:,end) = 0;
        sanshitu_rotate(vol_FBP);
        vol_FBP_Z = vol_FBP;
        vol_FBP_Z = squeeze(max(vol_FBP_Z,[],3));
        save('C:\Users\DELL\Desktop\Datacode_ABP\FBP\result_data\vol_FBP_Z','vol_FBP_Z'); 
    case {2}
        load LT_BP_data.mat
        vol_BP = vol_BP./max(vol_BP(:));
        vol_FBP = filterLaplacian(vol_BP);
        vol_FBP = max(vol_FBP./max(vol_FBP(:)),0);
        vol_FBP(:,:,1) = 0;
        vol_FBP(:,:,end) = 0;
        sanshitu_rotate(vol_FBP);
        vol_FBP_LT = vol_FBP;
        vol_FBP_LT = squeeze(max(vol_FBP_LT,[],3));
        save('C:\Users\DELL\Desktop\Datacode_ABP\FBP\result_data\vol_FBP_LT','vol_FBP_LT'); 
    case {3}
        load human_BP_data.mat
        vol_BP = vol_BP./max(vol_BP(:));
        vol_FBP = filterLaplacian(vol_BP);
        vol_FBP = max(vol_FBP./max(vol_FBP(:)),0);
        vol_FBP(:,:,1) = 0;
        vol_FBP(:,:,end) = 0;
        sanshitu_rotate(vol_FBP);
        vol_FBP_human = vol_FBP;
        vol_FBP_human = squeeze(max(vol_FBP_human,[],3));
        save('C:\Users\DELL\Desktop\Datacode_ABP\FBP\result_data\vol_FBP_human','vol_FBP_human'); 
    case {4}
        load T_BP_data.mat
        vol_BP = vol_BP./max(vol_BP(:));
        vol_FBP = filterLaplacian(vol_BP);
        vol_FBP = max(vol_FBP./max(vol_FBP(:)),0);
        vol_FBP(:,:,1) = 0;
        vol_FBP(:,:,end) = 0;
        sanshitu_rotate(vol_FBP);
        vol_FBP_T = vol_FBP;
        vol_FBP_T = squeeze(max(vol_FBP_T,[],3));
        save('C:\Users\DELL\Desktop\Datacode_ABP\FBP\result_data\vol_FBP_T','vol_FBP_T'); 

end
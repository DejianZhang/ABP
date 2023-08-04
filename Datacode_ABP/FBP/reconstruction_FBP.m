function reconstruction_FBP(scene)
%   1 - Z
%   2 - LT
%   3 - human
%   4 - T
% Load scene & set visualization parameter
Path = pwd;
switch scene
    case {1}
        load Z_BP_data.mat
        vol_BP = vol_BP./max(vol_BP(:));
        vol_FBP = filterLaplacian(vol_BP);
        vol_FBP = max(vol_FBP./max(vol_FBP(:)),0); 
        sanshitu_rotate(vol_FBP);
        vol_FBP_Z = vol_FBP;
        vol_FBP_Z = squeeze(max(vol_FBP_Z,[],3));
        save_path = strcat(Path,'\data_result\vol_FBP_Z');
        save(save_path,'vol_FBP_Z'); 
    case {2}
        load LT_BP_data.mat
        vol_BP = vol_BP./max(vol_BP(:));
        vol_FBP = filterLaplacian(vol_BP);
        vol_FBP = max(vol_FBP./max(vol_FBP(:)),0);
        sanshitu_rotate(vol_FBP);
        vol_FBP_LT = vol_FBP;
        vol_FBP_LT = squeeze(max(vol_FBP_LT,[],3));
        save_path = strcat(Path,'\data_result\vol_FBP_LT');
        save(save_path,'vol_FBP_LT'); 
    case {3}
        load Lambertian_human_data.mat
        vol_BP = vol;
        vol_FBP = filterLaplacian(vol_BP);
        vol_FBP = vol_FBP./max(vol_FBP(:));
        sanshitu_rotate(vol_FBP);
        vol_FBP_Lambertian_human = vol_FBP;
        vol_FBP_Lambertian_human = squeeze(max(vol_FBP_Lambertian_human,[],3));
        save_path = strcat(Path,'\data_result\vol_FBP_Lambertian_human');
        save(save_path,'vol_FBP_Lambertian_human'); 
    case {4}
        load Lambertian_T_data.mat
        vol_BP = vol_BP_Lambertian_T;
        vol_FBP = filterLaplacian(vol_BP);
        vol_FBP = vol_FBP./max(vol_FBP(:));
        sanshitu_rotate(vol_FBP);
        vol_FBP_Lambertian_T = vol_FBP;
        vol_FBP_Lambertian_T = squeeze(max(vol_FBP_Lambertian_T,[],3));
        save_path = strcat(Path,'\data_result\vol_FBP_Lambertian_T');
        save(save_path,'vol_FBP_Lambertian_T'); 
end
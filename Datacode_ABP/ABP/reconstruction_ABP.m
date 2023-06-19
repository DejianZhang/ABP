function reconstruction_ABP(scene)
%   1 - Z
%   2 - LT
%   3 - human
%   4 - T
%   5 - NCU
%   6 - nonconfocal U
% Load scene & set visualization parameter
Path = pwd;
switch scene
    case {1}
        load Z_BP_data.mat
        vol_ABP = ABP(vol_BP);
        vol_ABP = vol_ABP./max(vol_ABP(:));
        vol_ABP_Z = squeeze(max(vol_ABP,[],3));
        save_path = strcat(Path,'\data_result\vol_ABP_Z');
        save(save_path,'vol_ABP_Z'); 
    case {2}
        load LT_BP_data.mat
        vol_ABP = ABP(vol_BP);
        vol_ABP = vol_ABP./max(vol_ABP(:));
        vol_ABP_LT = squeeze(max(vol_ABP,[],3));
        save_path = strcat(Path,'\data_result\vol_ABP_LT');
        save(save_path,'vol_ABP_LT'); 
    case {3}
        load Lambertian_human_data.mat
        figure
        vol_ABP = ABP(vol);
        vol_ABP = vol_ABP./max(vol_ABP(:));
        vol_ABP_Lambertian_human = squeeze(max(vol_ABP,[],3));
        save_path = strcat(Path,'\data_result\vol_ABP_Lambertian_human');
        save(save_path,'vol_ABP_Lambertian_human'); 
    case {4}
        load Lambertian_T_data.mat
        figure
        vol_ABP = ABP(vol_BP_Lambertian_T);
        vol_ABP = vol_ABP./max(vol_ABP(:));
        vol_ABP_Lambertian_T = squeeze(max(vol_ABP,[],3));
        save_path = strcat(Path,'\data_result\vol_ABP_Lambertian_T');
        save(save_path,'vol_ABP_Lambertian_T'); 
    case {5}
        load NCU_BP_data.mat
        vol_ABP_N = ABP(vol_BP_N);
        figure
        vol_ABP_C = ABP(vol_BP_C);
        figure
        vol_ABP_U = ABP(vol_BP_U);      
end
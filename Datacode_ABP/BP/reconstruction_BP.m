function reconstruction_BP(scene)
%   1 - Z
%   2 - LT
%   3 - human
%   4 - T
% Load scene & set visualization parameter
Path = pwd;
switch scene
    case {1}
        load Z.mat
        vol_BP_Z = BP_LCT(scene);
        vol_BP_Z = vol_BP_Z./max(vol_BP_Z(:));
        vol_BP_Z = squeeze(max(vol_BP_Z,[],3));
        sanshitu_rotate(vol_BP_Z);
        save_path = strcat(Path,'\data_result\vol_BP_Z');
        save(save_path,'vol_BP_Z'); 
    case {2}
        load LT.mat
        vol_BP_LT = BP_LCT(scene);
        vol_BP_LT = vol_BP_LT./max(vol_BP_LT(:));
        vol_BP_LT = squeeze(max(vol_BP_LT,[],3));
        vol_BP_LT = fliplr(vol_BP_LT);
        sanshitu_rotate(vol_BP_LT);
        save_path = strcat(Path,'\data_result\vol_BP_LT');
        save(save_path,'vol_BP_LT'); 
    case {3}
        load Lambertian_human.mat
        vol_BP_Lambertian_human = BP_LCT(scene);
        vol_BP_Lambertian_human = vol_BP_Lambertian_human./max(vol_BP_Lambertian_human(:));
        vol_BP_Lambertian_human = squeeze(max(vol_BP_Lambertian_human,[],3));
        sanshitu_rotate(vol_BP_Lambertian_human);
        save_path = strcat(Path,'\data_result\vol_BP_Lambertian_human');
        save(save_path,'vol_BP_Lambertian_human'); 
    case {4}
        load Lambertian_T.mat %140ps time jitter
        vol_BP_Lambertian_T = BP_LCT(scene);
        vol_BP_Lambertian_T = vol_BP_Lambertian_T./max(vol_BP_Lambertian_T(:));
        vol_BP_Lambertian_T = squeeze(max(vol_BP_Lambertian_T,[],3));
        sanshitu_rotate(vol_BP_Lambertian_T);
        save_path = strcat(Path,'\data_result\vol_BP_Lambertian_T');
        save(save_path,'vol_BP_Lambertian_T'); 
end
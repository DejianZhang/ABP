function reconstruction_FK(scene)
%   1 - Z
%   2 - LT
%   3 - human
%   4 - T
% Load scene & set visualization parameter
Path = pwd;
switch scene
    case {1}
        load Z.mat
        tof_data(:,:,1:500)=0;
        tof_data(:,:,1200:end)=0;
        vol_FK_Z = FK(tof_data, [], 0.8, 2048, 5e-12); 
        vol_FK_Z=(max(vol_FK_Z,[],3));
        vol_FK_Z=vol_FK_Z/max(max(vol_FK_Z));
        sanshitu_rotate(vol_FK_Z)
        save_path = strcat(Path,'\data_result\vol_FK_Z');
        save(save_path,'vol_FK_Z'); 
    case {2}
        load LT.mat
        tof_data(:,:,1:500)=0;
        tof_data(:,:,1200:end)=0;
        tof_data = rot90(tof_data,3);
        vol_FK_LT = FK(tof_data, [], 0.8, 2048, 5e-12);
        vol_FK_LT=(max(vol_FK_LT,[],3));
        vol_FK_LT=vol_FK_LT/max(max(vol_FK_LT));
        vol_FK_LT = fliplr(vol_FK_LT);
        sanshitu_rotate(vol_FK_LT)
        save_path = strcat(Path,'\data_result\vol_FK_LT');
        save(save_path,'vol_FK_LT'); 
    case {3}
        load Lambertian_human.mat
        vol_FK_Lambertian_human = FK(tof_data, [], 0.8, 2048, 5e-12);
        vol_FK_Lambertian_human=(max(vol_FK_Lambertian_human,[],3));
        vol_FK_Lambertian_human = rot90(vol_FK_Lambertian_human,3);
        vol_FK_Lambertian_human=vol_FK_Lambertian_human/max(max(vol_FK_Lambertian_human));
        sanshitu_rotate(vol_FK_Lambertian_human)
        save_path = strcat(Path,'\data_result\vol_FK_Lambertian_human');
        save(save_path,'vol_FK_Lambertian_human');
    case {4}
        load Lambertian_T.mat
        vol_FK_Lambertian_T = FK(tof_data, [], 0.8, 2048, 5e-12);
        vol_FK_Lambertian_T=(max(vol_FK_Lambertian_T,[],3));
        vol_FK_Lambertian_T = rot90(vol_FK_Lambertian_T,3);
        vol_FK_Lambertian_T=vol_FK_Lambertian_T/max(max(vol_FK_Lambertian_T));
        sanshitu_rotate(vol_FK_Lambertian_T)
        save_path = strcat(Path,'\data_result\vol_FK_Lambertian_T');
        save(save_path,'vol_FK_Lambertian_T');
end
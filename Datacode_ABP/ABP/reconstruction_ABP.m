function reconstruction_ABP(scene)
%   1 - Z
%   2 - LT
%   3 - human
%   4 - T
% Load scene & set visualization parameter
switch scene
    case {1}
        load Z_BP_data.mat
        vol_ABP = ABP(vol_BP);
        vol_ABP = vol_ABP./max(vol_ABP(:));
        vol_ABP_Z = squeeze(max(vol_ABP,[],3));
        save('C:\Users\DELL\Desktop\Datacode_ABP\ABP\data_result\vol_ABP_Z','vol_ABP_Z'); 
    case {2}
        load LT_BP_data.mat
        vol_ABP = ABP(vol_BP);
        vol_ABP = vol_ABP./max(vol_ABP(:));
        vol_ABP_LT = squeeze(max(vol_ABP,[],3));
        save('C:\Users\DELL\Desktop\Datacode_ABP\ABP\data_result\vol_ABP_LT','vol_ABP_LT'); 
    case {3}
        load human_BP_data.mat
        vol_ABP = ABP(vol_BP);
        vol_ABP = vol_ABP./max(vol_ABP(:));
        vol_ABP_human = squeeze(max(vol_ABP,[],3));
        save('C:\Users\DELL\Desktop\Datacode_ABP\ABP\data_result\vol_ABP_human','vol_ABP_human'); 
    case {4}
        load T_BP_data.mat
        vol_ABP = ABP(vol_BP);
        vol_ABP = vol_ABP./max(vol_ABP(:));
        vol_ABP_T = squeeze(max(vol_ABP,[],3));
        save('C:\Users\DELL\Desktop\Datacode_ABP\ABP\data_result\vol_ABP_T','vol_ABP_T'); 
    case {5}
        load NCU_BP_data.mat
        vol_ABP_N = ABP(vol_BP_N);
        figure
        vol_ABP_C = ABP(vol_BP_C);
        figure
        vol_ABP_U = ABP(vol_BP_U);        
end
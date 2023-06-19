function reconstruction_EBP(scene)
%   1 - Z
%   2 - LT
%   3 - human
%   4 - T
% Load scene & set visualization parameter
Path = pwd;
switch scene
    case {1}
        load Z.mat
        tof_data(:,:,1:500) = 0;
        bin_resolution = 5e-12;
        vol_EBP_Z = EBP(tof_data,bin_resolution,0.46,0.8,0.05);
        vol_EBP_Z = rot90(vol_EBP_Z,3);
        load color.mat
        imagesc(vol_EBP_Z);
        colormap(mycolormap);
        axis square;  
        save_path = strcat(Path,'\data_result\vol_EBP_Z');
        save(save_path,'vol_EBP_Z'); 
    case {2}
        load LT.mat
        bin_resolution = 5e-12;
        tof_data = tof_data;
        tof_data(:,:,1:500) = 0;
        rect_dataT = EBP(tof_data,bin_resolution,0.46,0.6,0.1); 
        rect_dataT = rot90(rect_dataT,3);
        rect_dataL = EBP(tof_data,bin_resolution,0.64,0.6,0.1);
        rect_dataL = rot90(rect_dataL,3);
        vol_EBP_LT = rect_dataL+rect_dataT;
        vol_EBP_LT = vol_EBP_LT./max(vol_EBP_LT(:));
        vol_EBP_LT = fliplr(vol_EBP_LT);
        load color.mat
        subplot(1,3,1);
        imagesc(rect_dataT);
        colormap(mycolormap);
        axis square;
       
        subplot(1,3,2);
        imagesc(rect_dataL);
        colormap(mycolormap);
        axis square; 
        
        subplot(1,3,3);
        imagesc(vol_EBP_LT); 
        colormap(mycolormap);
        axis square;
        save_path = strcat(Path,'\data_result\vol_EBP_LT');
        save(save_path,'vol_EBP_LT');  
    case {3}
        load Lambertian_human.mat
        vol_EBP_human = EBP3D(tof_data,0.7);
        save_path = strcat(Path,'\data_result\vol_EBP_human');
        save(save_path,'vol_EBP_human'); 
    case {4}
        load Lambertian_T.mat
        vol_EBP_T = EBP3D(tof_data,0.7);
        save_path = strcat(Path,'\data_result\vol_EBP_T');
        save(save_path,'vol_EBP_T'); 
end


end

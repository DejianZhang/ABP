function reconstruction_EBP(scene)
%   1 - Z
%   2 - LT
%   3 - human
%   4 - T
% Load scene & set visualization parameter

switch scene
    case {1}
        load Z.mat
        tof_data(:,:,1:500) = 0;
        bin_resolution = 5e-12;
        rect_dataZ = EBP(tof_data,bin_resolution,0.46,0.8,0.05);
        rect_dataZ = rot90(rect_dataZ,3);
        load color.mat
        imagesc(rect_dataZ);
        colormap(mycolormap);
        axis square;  
        save('C:\Users\DELL\Desktop\Datacode_ABP\EBP\result_data\vol_EBP_Z','rect_dataZ'); 
    case {2}
        load LT.mat
        bin_resolution = 5e-12;
        tof_data = tof_data;
        tof_data(:,:,1:500) = 0;
        rect_dataT = EBP(tof_data,bin_resolution,0.46,0.6,0.1); 
        rect_dataT = rot90(rect_dataT,3);
        rect_dataL = EBP(tof_data,bin_resolution,0.64,0.6,0.1);
        rect_dataL = rot90(rect_dataL,3);
        rect_data_LT = rect_dataL+rect_dataT;
        rect_data_LT = rect_data_LT./max(rect_data_LT(:));
        
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
        imagesc(rect_data_LT); 
        colormap(mycolormap);
        axis square;
        save('C:\Users\DELL\Desktop\Datacode_ABP\EBP\result_data\vol_EBP_LT','rect_data_LT'); 
    case {3}
        load human.mat
        vol_EBP_human = EBP3D;
        save('C:\Users\DELL\Desktop\Datacode_ABP\EBP\result_data\vol_EBP_human','vol_EBP_human'); 
    case {4}
        load T.mat
        bin_resolution = 5e-12;
        rect_dataT = EBP(tof_data,bin_resolution,0.5,0.6,0.4);
        load color.mat
        imagesc(rect_dataT);
        colormap(mycolormap);
        axis square;
        save('C:\Users\DELL\Desktop\Datacode_ABP\EBP\result_data\vol_EBP_T','rect_dataT'); 
end


end

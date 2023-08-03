function rect_data2 = EBP(tof_data,bin_resolution,z_distance,gama,alpha)

rect_data0 = BP(z_distance,tof_data,bin_resolution);
rect_data0=(rect_data0/max(max(rect_data0)));
ground_turth = rect_data0;

    
ground_turth=(ground_turth/max(max(ground_turth)));
tof_data1 = tof(ground_turth,bin_resolution,z_distance);
tof_data_delta = tof_data1 - alpha.*tof_data;

rect_data1 = BP(z_distance,tof_data_delta,bin_resolution);
rect_data1=(rect_data1/max(max(rect_data1)));
rect_data2 = rect_data0 - gama.*rect_data1;
    
rect_data2 = rect_data2 - min(rect_data2(:));
rect_data2=(rect_data2/max(max(rect_data2)));

    


end


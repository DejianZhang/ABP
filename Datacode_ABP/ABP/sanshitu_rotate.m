function sanshitu_rotate(rotate_data)
% rect_data0=scan_data;
load color.mat

final_data=(max(rotate_data,[],3));
final_data=final_data/max(max(final_data));
imagesc(final_data);%
colormap(mycolormap);
axis square;

end


    
    
    
    
    
    

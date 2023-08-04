function tof_data =tof3D(ground_turth,Z,Z0)
ground_turth = 10*ground_turth./max(ground_turth(:));
ground_turth0 = round(ground_turth);

X0=64; Y0=64;   

bin_resolution = 5e-12;
c              = 3e8;  
width=0.8;
X_voxel=width/(X0-1);         
Y_voxel=width/(Y0-1);         
Z_voxel=c*bin_resolution*2;  
tof_data = zeros(64,64,2048);
Y=1:1:Y0;  Y=repmat(Y,Y0,1);  Y=repmat(Y,1,1,Z0);
X=1:1:X0;  X=repmat(X',1,X0); X=repmat(X,1,1,Z0);
Z=repmat(Z,X0,1);  Z=repmat(Z,1,1,X0); Z=permute(Z,[1 3 2]);
for x=1:64
    for y=1:64 
        distance=2*(((X_voxel.*(X-x)).^2+(Y_voxel.*(Y-y)).^2+(Z_voxel.*Z).^2).^0.5);
        h = distance(:);
        ground_turth0 = ground_turth0(:);
        h = repelem(h,ground_turth0);
        h = h/c;
        delta = 0:bin_resolution:2047*bin_resolution;
        H = hist(h,delta);
        tof_data(x,y,:)=H;    
    end
    display(x);
end

end
function tof_data =tof(ground_turth)
X0=64; Y0=64; Z0=1;   %物空间划分

bin_resolution = 5e-12; % Native bin resolution for SPAD is 4 ps
c              = 3e8;   % Speed of light (meters per second)
width=0.8;
X_voxel=width/X0;           %物空间划分
Y_voxel=width/Y0;           %物空间划分
tof_data = zeros(64,64,2048);
Y=1:1:Y0;  Y=repmat(Y,Y0,1);  Y=repmat(Y,1,1,Z0);
X=1:1:X0;  X=repmat(X',1,X0); X=repmat(X,1,1,Z0);
Z=1:1:Z0;  Z=repmat(Z,X0,1);  Z=repmat(Z,1,1,X0); Z=permute(Z,[1 3 2]);
for x=1:64
    for y=1:64 
        distance=2*(((X_voxel.*(X-x)).^2+(Y_voxel.*(Y-y)).^2+(0.5).^2).^0.5);
        ture_distance = ground_turth;
        ture_distance(ture_distance<0.5)=0; 
        ture_distance(ture_distance>0.5)=1;
        distance=distance.*ture_distance;
        h = distance(:);
        h = h/c;
        
%         time_jitter = 140e-12;            %加入时间抖动
%         b = -time_jitter; a = time_jitter;
%         jitter = (rand(length(h),1)*(b-a))+a;
%         h = h + jitter;
%         h(h<0)=0;
        
        delta = 0:bin_resolution:2047*bin_resolution;
        H = hist(h,delta);
        tof_data(x,y,:)=H;    
    end
end

end
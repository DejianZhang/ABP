function rect_data0 = BP(z_distance,tof_data,bin_resolution)
%参数设置
X0=64; Y0=64; Z0=1;   
x0=64; y0=64;         

c              = 3e8;   
width=0.8;
X_voxel=width/X0;          
Y_voxel=width/Y0;           
Z_voxel=c*bin_resolution;   
delta=0.0177/3;             
rect_data0=zeros(X0,Y0);    
weight_data=zeros(X0,Y0);
rect_data1=zeros(X0,Y0);


z_distance = z_distance./(3e8*bin_resolution);

%物空间坐标 
Y=1:1:Y0;  Y=repmat(Y,Y0,1);  Y=repmat(Y,1,1,Z0);
X=1:1:X0;  X=repmat(X',1,X0); X=repmat(X,1,1,Z0);
Z=1:1:Z0;  Z=repmat(Z,X0,1);  Z=repmat(Z,1,1,X0); Z=permute(Z,[1 3 2]);
display('Inverting...');
tic;
%比较距离
for i=1:x0
    for j=1:y0
        %提取第i行第j列的 tof
        tof_data0=tof_data(i,j,:);  tof_data0=reshape(tof_data0,1,2048);
        bin=find(tof_data0);                 
        tof_distance=bin_resolution*c*bin*0.5;
        x=i; y=j;                            
        distance=((X_voxel.*(X-x)).^2+(Y_voxel.*(Y-y)).^2+(Z_voxel.*z_distance).^2).^0.5;
        for k=1:length(tof_distance)
            delta_distance=abs(distance-tof_distance(1,k));
            delta_distance(delta_distance>delta)=0;        
            
            weight_data0=delta_distance./delta_distance;
            weight_data0(isnan(weight_data0))=0;
            weight_data=weight_data+weight_data0;
            
            distance0=weight_data0.*(tof_data0(1,bin(1,k)));
            distance0(distance0==inf)=0;
            
            rect_data0=rect_data0+distance0;
        end
    end
    p=(rect_data0/max(max(rect_data0)));
    rect_data1=rect_data1+rect_data0.*p;
    display(i,'x0');
end
display('... done.');
display(toc);

end
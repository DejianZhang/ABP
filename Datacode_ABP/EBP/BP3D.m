function vol = BP3D(tof_data,Z,Z0) 



X0=64; Y0=64;  

x0=64; y0=64;               
bin_resolution = 4e-12;   
c              = 3e8;       
width=0.8;
X_voxel=width/X0;         
Y_voxel=width/Y0;           
Z_voxel=c*bin_resolution;  
delta=0.0177/3;             
vol=zeros(X0,Y0,Z0);    
weight_data0=zeros(X0,Y0,Z0);
weight_datax=zeros(X0,Y0,Z0);


Y=1:1:Y0;  Y=repmat(Y,Y0,1);  Y=repmat(Y,1,1,Z0);
X=1:1:X0;  X=repmat(X',1,X0); X=repmat(X,1,1,Z0);

Z=repmat(Z,X0,1);  Z=repmat(Z,1,1,X0); Z=permute(Z,[1 3 2]);
display('Inverting...');
tic;


for i=1:x0
    for j=1:y0

        tof_data0=tof_data(i,j,:);  tof_data0=reshape(tof_data0,1,2048);
        bin=find(tof_data0);                 
        tof_distance=bin_resolution*c*bin*0.5;
        x=i; y=j;                            
        distance=((X_voxel.*(X-x)).^2+(Y_voxel.*(Y-y)).^2+(Z_voxel.*Z).^2).^0.5;
        for k=1:length(tof_distance)
            delta_distance=abs(distance-tof_distance(1,k));
            delta_distance(delta_distance>delta)=0;     
            
            weight_data1=delta_distance./delta_distance;
            weight_data1(isnan(weight_data1))=0;
            weight_data0=weight_data0+weight_data1;
            
            distance0=weight_data1.*(tof_data0(1,bin(1,k)));
            distance0(distance0==inf)=0;
            
            vol=vol+distance0;
        end

    end
    display(i,'x0');
end
display('... done.');
display(toc);


rect_data0 = vol;
% View result
subplot(1,3,1);
rect_data0=squeeze(max(rect_data0,[],3));
rect_data0=(rect_data0/max(max(rect_data0)));
imagesc(rect_data0);
load color.mat
colormap(mycolormap);
axis square;

end


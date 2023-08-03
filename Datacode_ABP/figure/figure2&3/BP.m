%参数设置
X0=64; Y0=64; Z0=1;   %物空间划分
x0=64; y0=64;         %扫描空间划分
bin_resolution = 5e-12; % Native bin resolution for SPAD is 4 ps
c              = 3e8;   % Speed of light (meters per second)
width=0.8;
X_voxel=width/X0;           %物空间划分
Y_voxel=width/Y0;            %物空间划分
Z_voxel=c*bin_resolution;   %物空间划分
delta=0.0177/3;             %判据常数
rect_data0=zeros(X0,Y0);    %初始化结果
weight_data=zeros(X0,Y0);
rect_data1=zeros(X0,Y0);


% rect_data = rot90(rect_data);
% rect_data(:,:,1000:end)=0;
% rect_data(:,:,1:500)=0;
z_distance = 0.5./(3e8*bin_resolution);
%tof_data = depsf(rect_data);
z_trim=0; z_end=2048;
% 
% tof_data(:,:,1:z_trim) = 0;
% tof_data(:,:,z_end:end) = 0;
% tof_data(tof_data<3)=0; 
% caiyang0=zeros(1,2048); caiyang0(1,1:10:2048)=1; caiyang=zeros(64,64,2048);
% for i=1:1:64
%     for j=1:1:64
%         caiyang(i,j,:)=caiyang0;
%     end
% end
% tof_data=tof_data.*caiyang;

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
        bin=find(tof_data0);                  %提取非零tof的bin数
        tof_distance=bin_resolution*c*bin*0.5;%计算第i行第j列tof的距离
        x=i; y=j;                             %扫描点位置
        distance=((X_voxel.*(X-x)).^2+(Y_voxel.*(Y-y)).^2+(Z_voxel.*z_distance).^2).^0.5;
        for k=1:length(tof_distance)
            delta_distance=abs(distance-tof_distance(1,k));%物扫距离相减的绝对值
            delta_distance(delta_distance>delta)=0;        %筛选距离
            
            weight_data0=delta_distance./delta_distance;
            weight_data0(isnan(weight_data0))=0;%清零奇异点
            weight_data=weight_data+weight_data0;
            
            distance0=weight_data0.*(tof_data0(1,bin(1,k)));%分配权重
            distance0(distance0==inf)=0;%清零奇异点
            
            rect_data0=rect_data0+distance0;%储存最终结果
        end
    end
    p=(rect_data0/max(max(rect_data0)));
    rect_data1=rect_data1+rect_data0.*p;
    display(i,'x0');
end
display('... done.');
display(toc);
% View result
subplot(1,3,1);
rect_data0=rect_data0.^1;
rect_data0=(rect_data0/max(max(rect_data0)));
imagesc(rect_data0);
colormap('gray');
axis square;

subplot(1,3,2);
weight_data=rect_data1.^1;
weight_data=(weight_data/max(max(weight_data)));
imagesc(weight_data);
colormap('gray');
axis square;

subplot(1,3,3);
final_data=weight_data.*rect_data0;
final_data=(final_data/max(max(final_data)))*255;
imagesc(final_data);
colormap('gray');
axis square;
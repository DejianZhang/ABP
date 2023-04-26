function vol = reconstruction_BP(tof_data,Z,Z0) 
%Load tof_data first before running code
%if the scence is T,then the code is vol = reconstruction_BP(tof_data,[301:350],50) 
%if the scence is human,then the code is vol = reconstruction_BP(tof_data,[666:765],100)
%if the scence is LT,then the code is vol = reconstruction_BP(tof_data,[250:516],267) (The running time is too long, it is recommended to use BP_ LCT obtaining Results)
%if the scence is Z,then the code is vol = reconstruction_BP(tof_data,[200:466],267) (The running time is too long, it is recommended to use BP_ LCT obtaining Results)
%Parameter settings
X0=64; Y0=64;   %Object space division

x0=64; y0=64;               %Scan space partitioning
bin_resolution = 5e-12;     % Native bin resolution for SPAD is 5 ps
c              = 3e8;       % Speed of light (meters per second)
width=0.8;
X_voxel=width/X0;           %Object space division
Y_voxel=width/Y0;           %Object space division
Z_voxel=c*bin_resolution;   %Object space division
delta=0.0177/3;             %Criterion constant
vol=zeros(X0,Y0,Z0);    %Initialization Result
weight_data0=zeros(X0,Y0,Z0);
weight_datax=zeros(X0,Y0,Z0);

%Object space coordinates
Y=1:1:Y0;  Y=repmat(Y,Y0,1);  Y=repmat(Y,1,1,Z0);
X=1:1:X0;  X=repmat(X',1,X0); X=repmat(X,1,1,Z0);
% Z=333:1:333;  
Z=repmat(Z,X0,1);  Z=repmat(Z,1,1,X0); Z=permute(Z,[1 3 2]);
display('Inverting...');
tic;

%Compare distances
for i=1:x0
    for j=1:y0
        %Extract tof from the i-th row and jth column
        tof_data0=tof_data(i,j,:);  tof_data0=reshape(tof_data0,1,2048);
        bin=find(tof_data0);                  %Extracting the bin number of non zero tof
        tof_distance=bin_resolution*c*bin*0.5;%Calculate the distance between row i and column j of tof
        x=i; y=j;                             %Scan point position
        distance=((X_voxel.*(X-x)).^2+(Y_voxel.*(Y-y)).^2+(Z_voxel.*Z).^2).^0.5;
        for k=1:length(tof_distance)
            delta_distance=abs(distance-tof_distance(1,k));%Absolute value of subtracting object scanning distance
            delta_distance(delta_distance>delta)=0;        %Filter distance
            
            weight_data1=delta_distance./delta_distance;
            weight_data1(isnan(weight_data1))=0;%Zeroing Singularities
            weight_data0=weight_data0+weight_data1;
            
            distance0=weight_data1.*(tof_data0(1,bin(1,k)));%Assign weight
            distance0(distance0==inf)=0;%Zeroing Singularities
            
            vol=vol+distance0;%Store final results
        end

    end
    display(i,'x0');
end
display('... done.');
display(toc);
%Organize data

rect_data0 = vol;
% View result
subplot(1,3,1);
rect_data0=squeeze(max(rect_data0,[],3));
rect_data0=(rect_data0/max(max(rect_data0)));
imagesc(rect_data0);%
load color.mat
colormap(mycolormap);
axis square;

end


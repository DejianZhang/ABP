function vol_ABP = ABP(vol_BP)
%Extract surface
for i = 1:64
    for j = 1:64
        vol_ABP = vol_BP(i,j,:);
        vol_ABP= vol_ABP(:);
        [maxVal,maxInd] = max(vol_ABP);
        vol_ABP(vol_ABP<maxVal) = 0;
        vol(i,j,:) = vol_ABP;
    end
end
%Determine surface position
Row = [];
Col = [];
Layer = [];
Voxel = [];
size_vol = size(vol);
dimension = size_vol(1,3);
for layer=1:dimension
    X = vol(:,:,layer);
    [row,col,voxel] = find(X);
    Row=[Row,row'];
    Col=[Col,col'];
    Layer = [Layer,(layer.*ones(length(voxel),1))'];
    Voxel = [Voxel,voxel'];
end
Voxel=Voxel./(max(Voxel(:)));
%Surface ABP
vol_ABP=vol;
vol_ABP=vol_ABP./(max(vol_ABP(:)));
max_number = 1.1;
delta = zeros(64,64,dimension);
tic
for n=1:length(Layer)
delta0 = caculate_F3D_2(vol_ABP,Row(1,n),Col(1,n),Layer(1,n),0.4,Row,Col,Layer,Voxel);
delta(Row(1,n),Col(1,n),Layer(1,n))=delta0;
end
toc
vol_ABP = vol_ABP + delta;

sanshitu_rotate(vol_ABP)
end





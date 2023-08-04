function delta = caculate_F3D_2(zone,x,y,z,A,Row,Col,Layer,Voxel)
%Calculate the absorption between voxels
point = length(Layer);
delta=zeros(1,point);
x0 = ones(1,point).*x; y0 = ones(1,point).*y; z0 = ones(1,point).*z; 

distance = (Row-x0).^2+(Col-y0).^2+0.01*(Layer-z0).^2;
delta = A.*(zone(x,y,z).*Voxel)./distance;
delta(isinf(delta)) = 0;
fuhao = zone(x,y,z)-Voxel;
fuhao(fuhao>0)=1; fuhao(fuhao<0)=-1;
delta = delta.*fuhao;
delta =sum(delta(:));
end 
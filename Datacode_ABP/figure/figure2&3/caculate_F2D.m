function delta = caculate_F2D(zone,x,y,A,power,max_number)

delta=zeros(64,64);
fuhao = zeros(64,64);
if zone(x,y)>=max_number || zone(x,y) == 0
    delta = 0;
else
    for i=1:64
        for j=1:64
            if  zone(i,j)>=max_number
                delta(i,j)=0;
            else
                delta(i,j)=zone(i,j)*zone(x,y).*A/((abs((x-i)^power)+abs((y-j)^power)));
                fuhao(i,j)=zone(x,y)-zone(i,j);
            end
        end
    end
    delta(x,y)=0;
    fuhao(fuhao>0)=1; fuhao(fuhao<0)=-1;
    delta = delta.*fuhao;
    delta =sum(delta(:));
end

end
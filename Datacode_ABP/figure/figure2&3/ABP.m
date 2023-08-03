% a = squeeze(max(vol_BP,[],3));
a = rect_data0;
a = a./max(a(:));
b=a;
subplot(1,3,1);
imagesc(a);
colormap('gray');
axis square;
max_number = 3;
n=1;
m = 64;
tic;
for numbers = 1:n
    delta = zeros(m,m);
    for x=1:m
        for y=1:m
            delta0 = caculate_F2D(a,x,y,0.4,2,max_number);
            delta(x,y)=delta0;
        end
    end
    a = a + delta;
end
subplot(1,3,2);
% a(a>max_number)=max_number;
% a=a-min(a(:));
a=(a/max(max(a)));
a(a<0)=0;
imagesc(a);
colormap(mycolormap);
axis square;

subplot(1,3,3);
imagesc(zone);
colormap(mycolormap);
axis square;

toc;
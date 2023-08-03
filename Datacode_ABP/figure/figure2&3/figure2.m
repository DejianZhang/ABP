figure
load cross.mat
load color.mat
tof_data =tof(zone);
BP;

subplot(2,2,1)
imshow(zone)
axis square;
set(gca,'XTick',[]);
set(gca,'YTick',[]);

subplot(2,2,3)
imagesc(rect_data0);
colormap(mycolormap);
axis square;

set(gca,'XTick',[]);
set(gca,'YTick',[]);

subplot(2,2,[2,4])
surf(rect_data0);
shading interp
camlight
lighting phong
colormap(mycolormap);
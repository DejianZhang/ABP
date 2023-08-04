figure

load cross.mat
load color.mat
tof_data =tof(zone);
BP;
ABP;
subplot(2,1,1)
imagesc(rect_data0);
colormap(mycolormap);
axis square;
set(gca,'XTick',[]);
set(gca,'YTick',[]);



subplot(2,1,2)
imagesc(a);
colormap(mycolormap);
axis square;
set(gca,'XTick',[]);
set(gca,'YTick',[]);

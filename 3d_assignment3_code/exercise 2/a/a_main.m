clc,clear,close all
% load the images
l = imread('left_rect_chessboard.jpg');
r = imread('right_rect_chessboard.jpg');

il = rgb2gray(l);
ir = rgb2gray(r);
w = 21;                                 %set window size = 19
D_min = 0;                            %set the search range  
D_max = 170;

%get disparity map
d_best = dis(il,ir,w,D_min,D_max);
figure(1)
imshow(l);
figure(2)
imshow(r);
figure(3)
imagesc(mat2gray(d_best)),colorbar;
cmap=colormap; 
print(gcf,'-dpng','D_MAP(21-0-170).png')
save('d_best')
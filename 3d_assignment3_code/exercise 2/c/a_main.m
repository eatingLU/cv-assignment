clc,clear,close all
% load the images
l = imread('left_rect_chessboard.jpg');
r = imread('right_rect_chessboard.jpg');

il = rgb2gray(l);
ir = rgb2gray(r);
w = 11;                                 %set window size 
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
imwrite(mat2gray(d_best),'D_ZSAD_MAP(11-0-170).jpg')
print(gcf,'-dpng','D_ZSAD_MAP(11-0-170).png')
save('d_best')
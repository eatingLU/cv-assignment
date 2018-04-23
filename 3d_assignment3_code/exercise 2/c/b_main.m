clc,clear,close all

l = imread('left_rect_hallway.jpg');
r = imread('right_rect_hallway.jpg');
load('stereo_calib.mat')
Kl = Ml';
Kr = Mr';
%calculate average f for both camera;
f = (Kl(1,1)+Kr(1,1))/2;
%calculate baseline using equation B = 1/2*trace(E*E')*eye(3) - E*E';
B = 1/2*trace(E*E')*eye(3) - E*E';
b_length = sqrt(B(1,1)+B(2,2)+B(3,3));
z = 1000:7000;
% d = fb/z;
d_m = f*b_length./z;
d = d_m;

%input parameters
il = double(rgb2gray(l));
ir = double(rgb2gray(r));
w = 21;
D_min = round(min(d));
D_max = round(max(d));

% function of disparity map;
d_best = dis(il,ir,w,D_min,D_max);

% show the images;
figure(1)
imshow(l);
figure(2)
imshow(r);
figure(3)
imagesc(mat2gray(d_best)),colorbar;
imwrite(mat2gray(d_best),'d_MAP_ZNCC_W21.jpg')
print(gcf,'-dpng','d_MAP_ZNCC_W21.png')

%% derivative of Gaussian
close all
clc
close all
r=3;
sigma=10;
G=gaussian(sigma);
Gd=gaussianDer(G,sigma);
subplot(222)
plot(Gd);
title('derivative')
%% magnitude and orientation
%im=rgb2gray(imread('zebra.png'));
im=imread('pn1.jpg');
img=gaussianConv(im,sigma);
subplot(221)
imshow(img,[])
title('original image');
[magnitude, orientation]=gradmag(G,img,sigma);
%% set a threshold
level1=0.9;
level2=0.5;
magnitude=im2bw(magnitude,level1);
orientation=im2bw(orientation,level2);
subplot(223)
imshow(magnitude,[]);
title(['maganitude of derivative image, level=', num2str(level1), 'sigma=', num2str(sigma)]);
subplot(224)
imshow(orientation , [-pi,pi])
title(['orientation of derivative image, level=', num2str(level2), 'sigma=', num2str(sigma)]);
hold on;
colormap(hsv);
colorbar;
hold off;
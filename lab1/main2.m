%% derivative of Gaussian
close all
clc
close all
r=3;
sigma=1;
G=gaussian(sigma,r);
Gd=gaussianDer(G,sigma,r);
subplot(222)
plot(Gd);
title('derivative')
%% magnitude and orientation
sigma_x=1;
sigma_y=1;
% im=rgb2gray(imread('zebra.png'));
im=imread('pn1.jpg');
subplot(221)
imshow(im)
title('original image');
[magnitude, orientation]=gradmag(G,im,sigma_x,sigma_y,r);
subplot(223)
imshow(magnitude,[]);
title('maganitude of derivative image');
subplot(224)
imshow(orientation , [-pi,pi])
title('orientation of derivative image');
hold on;
colormap(hsv);
colorbar;
hold off;
%% derivative of Gaussian
close all
clc
close all
r=3;
sigma=10;
G=gaussian(sigma,r);
Gd=gaussianDer(G,sigma,r);
subplot(222)
plot(Gd);
title('derivative')
%% magnitude and orientation
sigma_x=sigma;
sigma_y=sigma;
im=rgb2gray(imread('zebra.png'));
%im=imread('pn1.jpg');
subplot(221)
imshow(im)
title('original image');
[magnitude, orientation]=gradmag(G,im,sigma_x,sigma_y,r);
%% set a threshold
level1=0.1;
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
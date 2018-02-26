clc
clear all
close all
%% create an image
im=ones(10,10);
im=padarray(im,[100 100],0,'both');
figure(1)
imshow(im);
sigma=10;
F=ImageDerivatives(im, sigma, 'xx');
subplot(231)
imshow(F,[]);
title('type=xx');
F=ImageDerivatives(im, sigma, 'xy');
subplot(232)
imshow(F,[]);
title('type=xy');
F=ImageDerivatives(im, sigma, 'yx');
subplot(233)
imshow(F,[]);
title('type=yx');
F=ImageDerivatives(im, sigma, 'yy');
subplot(234)
imshow(F,[]);
title('type=yy');
F=ImageDerivatives(im, sigma, 'x');
subplot(235)
imshow(F,[]);
title('type=x');
F=ImageDerivatives(im, sigma, 'y');
subplot(236)
title('type=y');
imshow(F,[]);
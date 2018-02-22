clear all
clc
close all
im=imread('pn1.jpg');
sigma_x=1;
sigma_y=1;
r=3;
img=gaussianConv(im,sigma_x,sigma_y,r);
figure(1)
imshow(img,[]);
%% matlab function
imIn=imread('pn1.jpg');
n=[7 7];
sigma=1;
G=fspecial('gaussian',n,sigma);
imOut=conv2(imIn,G,'same');
figure(2)
imshow(imOut,[])
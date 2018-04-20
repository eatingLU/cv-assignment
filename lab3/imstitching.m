clear all
clc
close all
im1=im2single(rgb2gray(imread('left.jpg')));
im2=im2single(rgb2gray(imread('right.jpg')));
im=mosaic(im1,im2);
figure(1)
subplot(121)
imshow(im1);
subplot(122);
imshow(im2);
figure(2)
imshow(im);
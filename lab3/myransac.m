close all
clc
clear all
%% Vidulize top N matches
% im1 = im2single(imread('img1.pgm'));
% im2 = im2single(imread('img2.pgm'));
% N=50;
im1=im2single(rgb2gray(imread('left.jpg')));
im2=im2single(rgb2gray(imread('right.jpg')));
[m,n]=size(im1);
im2=imresize(im2,[m,n]);
% findmatches(im1,im2,N); 
%% Implement RANSAC
[frames1, desc1]=vl_sift(im1);
[frames2, desc2]=vl_sift(im2);
[matches, scores] = vl_ubcmatch(desc1,desc2);
match1=frames1(1:2,matches(1,:));
match2=frames2(1:2,matches(2,:));
x=findbestx(match1, match2);
T=[x(1) x(2) x(5); x(3) x(4) x(6); 0 0 1];
tform = affine2d(T');
image1_transformed = imwarp(im1,tform, 'bicubic');
tform = affine2d(inv(T)');
image2_transformed = imwarp(im2, tform, 'bicubic');
figure(1)
subplot(221)
imshow(im1);
subplot(222)
imshow(im2);
subplot(223)
imshow(image2_transformed);
subplot(224)
imshow(image1_transformed);
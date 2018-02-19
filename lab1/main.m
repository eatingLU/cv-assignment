clear all
clc
close all
im=imread('pn1.jpg');
img=gaussianConv(im,1,1);
imshow(img,[]);
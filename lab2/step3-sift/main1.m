close all
clc
clear all
im=imread('landscape-a.jpg');
im=rgb2gray(im);
sigma=10;
[r, c]=harris_scale(im);
%% show the corners
imshow(im)
hold on
scatter(c, r,'r.')
%% build descriptors

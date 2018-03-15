% Master file to make mosaic between two images
% Finds matches and uses RANSAC to compute homography matrix
% Mosaic images using homography
clear all
clc
close all
im1 = im2double(rgb2gray(imread('landscape-a.jpg')));
im2 = im2double(rgb2gray(imread('landscape-b.jpg')));
[match1, match2] = findMatches(im1,im2,30);

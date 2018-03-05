close all
clc
clear all
im=imread('landscape-a.jpg');
im=rgb2gray(im);
sigma=10;
[r, c]=harris(im,sigma);

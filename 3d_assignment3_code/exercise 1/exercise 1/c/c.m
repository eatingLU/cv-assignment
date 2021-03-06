clc
I = imread('lena.jpg');
h1 = fspecial('gaussian', 3, 8);
h2 = fspecial('gaussian', 6, 8);
h3 = fspecial('gaussian', 9, 8);
H1 = fspecial('gaussian', 9, 3);
H2 = fspecial('gaussian', 9, 6);
H3 = fspecial('gaussian', 9, 9);
I_f1 = imfilter(I,h1);
I_f2 = imfilter(I,h2);
I_f3 = imfilter(I,h3);
I_F1 = imfilter(I,H1);
I_F2 = imfilter(I,H2);
I_F3 = imfilter(I,H3);
subplot(2,3,1);
imshow(I_f1);
subplot(2,3,2);
imshow(I_f2);
subplot(2,3,3);
imshow(I_f3);
subplot(2,3,4);
imshow(I_F1);
subplot(2,3,5);
imshow(I_F2);
subplot(2,3,6);
imshow(I_F3);

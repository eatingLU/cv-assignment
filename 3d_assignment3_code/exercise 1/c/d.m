clear
clc
I_0 = imread('lena.jpg');
for i = 1:4
    g1 = fspecial('gaussian',10,sqrt(2)^i);
    I_1 = imfilter(I_0,g1);
    I_2 = imfilter(I_1,g1);
    I_3 = imfilter(I_2,g1);
    I_4 = imfilter(I_3,g1);
end
subplot(5,1,5);
imshow(I_0);
subplot(5,1,4);
imshow(I_1);
subplot(5,1,3);
imshow(I_2);
subplot(5,1,2);
imshow(I_3);
subplot(5,1,1);
imshow(I_4);

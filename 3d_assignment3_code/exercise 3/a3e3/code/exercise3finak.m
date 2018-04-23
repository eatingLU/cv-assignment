%%3D robot assignment 3 exercise 3.1
%reference:http://blog.csdn.net/linj_m/article/details/9833473
%reference:(principle of SIFT)http://blog.csdn.net/xiaowei_cqu/article/details/8069548
%% Input Image 
%specify the position of the image for imread
%Ia is left image in figure 1, Ib is right image in figure 2
Ia=imread('/Users/yuhaoxuan/Documents/3d_assignment3 /2018_ME41030_3D_Robot_Vision_Assignment_3_files/a3e3/code/Left_SmallOffice.jpg');
subplot(1,2,1)
imshow(Ia)
hold on
Ib=imread('/Users/yuhaoxuan/Documents/3d_assignment3 /2018_ME41030_3D_Robot_Vision_Assignment_3_files/a3e3/code/Right_SmallOffice.jpg');
subplot(1,2,2)
imshow(Ib)
hold on
%% rgb and single operation
%vl_sift need[0, 255]
Ia = single(rgb2gray(Ia)) ;
Ib = single(rgb2gray(Ib)) ;
%% vl_sift 
[fa, da] = vl_sift(Ia,'peakthresh',4.5,'levels',4);
subplot(1,2,1)
vl_plotframe(fa)
[fb, db] = vl_sift(Ib,'peakthresh',4.5,'levels',4);
subplot(1,2,2)
vl_plotframe(fb)
[matches, scores] = vl_ubcmatch(da, db,2) ;
%

%figure(2) ; clf ;
%imagesc(cat(2, Ia, Ib)) ;

%xa = fa(1,matches(1,:)) ;
%xb = fb(1,matches(2,:)) + size(Ia,2) ;
%ya = fa(2,matches(1,:)) ;
%yb = fb(2,matches(2,:)) ;

%hold on ;
%h = line([xa ; xb], [ya ; yb]) ;
%set(h,'linewidth', 1, 'color', 'b') ;

%vl_plotframe(fa(:,matches(1,:))) ;
%fb(1,:) = fb(1,:) + size(Ia,2) ;
%vl_plotframe(fb(:,matches(2,:))) ;
%axis image off ;
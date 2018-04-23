%%3D robot assignment 3 exercise 3.2
%parameter of vl_ubcmatch
%reference:http://blog.csdn.net/linj_m/article/details/9833473
%reference:(principle of SIFT)http://blog.csdn.net/xiaowei_cqu/article/details/8069548
%% Input Image 
%specify the position of the image for imread
%Ia is left image in figure 1, Ib is right image in figure 2
Ia=imread('H:\Downloads\3Dassignment3\vlfeat-0.9.21-bin\vlfeat-0.9\vlfeat-0.9.21\toolbox\Left_SmallOffice.jpg');
subplot(1,2,1)
imshow(Ia)
hold on
Ib=imread('H:\Downloads\3Dassignment3\vlfeat-0.9.21-bin\vlfeat-0.9\vlfeat-0.9.21\toolbox\Right_SmallOffice.jpg');
subplot(1,2,2)
imshow(Ib)
hold on
%% rgb and single operation
%vl_sift need[0, 255]
Ia = single(rgb2gray(Ia)) ;
Ib = single(rgb2gray(Ib)) ;
%% vl_sift 
[fa, da] = vl_sift(Ia);
subplot(1,2,1)
vl_plotframe(fa)
[fb, db] = vl_sift(Ib);
subplot(1,2,2)
vl_plotframe(fb)
%%vl_ubcmatch
k=1;
n=size(0.1:0.1:4,2)
machn=zeros(1,n);
for i=0.1:0.1:4
[matches, scores] = vl_ubcmatch(da, db,i) ;
machn(k)=size(matches,2);
k=k+1;
end
figure (11)
i=0.1:0.1:4;
plot(i,machn)
xlabel('Thresh');
ylabel('Number of matches');

% VL_UBCMATCH  Match SIFT features
%   MATCHES = VL_UBCMATCH(DESCR1, DESCR2) matches the two sets of SIFT
%   descriptors DESCR1 and DESCR2.
%
%   [MATCHES,SCORES] = VL_UBCMATCH(DESCR1, DESCR2) retuns the matches and
%   also the squared Euclidean distance between the matches.
%
%   The function uses the algorithm suggested by D. Lowe [1] to reject
%   matches that are too ambiguous.
%
%   VL_UBCMATCH(DESCR1, DESCR2, THRESH) uses the specified threshold
%   THRESH. A descriptor D1 is matched to a descriptor D2 only if the
%   distance d(D1,D2) multiplied by THRESH is not greater than the
%   distance of D1 to all other descriptors. The default value of
%   THRESH is 1.5.
%
%   The storage class of the descriptors can be either DOUBLE, FLOAT,
%   INT8 or UINT8. Usually integer classes are faster.
%
%   REFERENCES::
%     [1] D. G. Lowe, Distinctive image features from scale-invariant
%     keypoints. IJCV, vol. 2, no. 60, pp. 91-110, 2004.
%

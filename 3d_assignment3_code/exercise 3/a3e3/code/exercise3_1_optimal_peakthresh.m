%%3D robot assignment 3 exercise 3.1
% find optimal peak thresh parameter for keypoints
% answering the questions:
%1.how many keypoints obtained by default settings
%2. how many keypoints for optimal paramter
%3. what parameter do I change and why?
%reference:(english) http://www.vlfeat.org/overview/sift.html
%reference:(chinese)http://blog.csdn.net/sakhljdfhdkslf/article/details/41315237
%% Input Image 
%specify the position of the image for imread
%Ia is left image in figure 1, Ib is right image in figure 2
Ia=imread('H:\Downloads\3Dassignment3\vlfeat-0.9.21-bin\vlfeat-0.9\vlfeat-0.9.21\toolbox\Left_SmallOffice.jpg');
figure(1)
subplot(1,2,1)
imshow(Ia)
%hold on
Ib=imread('H:\Downloads\3Dassignment3\vlfeat-0.9.21-bin\vlfeat-0.9\vlfeat-0.9.21\toolbox\Right_SmallOffice.jpg');
subplot(1,2,2)
imshow(Ib)
%hold on
%% rgb and single operation
%vl_sift need[0, 255]
Ia = single(rgb2gray(Ia)) ;
Ib = single(rgb2gray(Ib)) ;
%% vl_sift change parameter peakthresh
kp=zeros(2,61);
kps=zeros(1,61);
mach=zeros(1,61);
mach_rate=zeros(1,61);
i=1;
for peak_thresh=0:0.5:30
 [fa, da] = vl_sift(Ia,'PeakThresh',peak_thresh) ;
 [fb, db] = vl_sift(Ib,'PeakThresh', peak_thresh) ;
 [matches, scores] = vl_ubcmatch(da, db) ;

kp(1,i)=size(fa,2);
kp(2,i)=size(fb,2);
mach(1,i)=size(matches,2);
i=i+1;
end
for j=1:61
    kps(1,j)=min(kp(1,j),kp(2,j));
end
mach_rate=mach./kps;
figure(63)
peak_thresh=0:0.5:30;
plot(peak_thresh,mach_rate);
xlabel('Peak thresh');
ylabel('Matching rate');
figure(64)
plot(peak_thresh,mach);
xlabel('Peak thresh');
ylabel('Number of matches');
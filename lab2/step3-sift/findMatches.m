function [match1, match2] = findMatches(im1, im2, threshold)
% Finds matching SIFT descriptors at Harris corner points in two images.

% Find all features and make descriptor of image 1
[r1,c1,s1] = harris_scale(im1);
[f1,d1] = descriptor(single(im1),r1,c1, s1);
%The vl_sift command requires a single precision gray scale image
% Find features and make descriptor of image 2
[r2,c2,s2] = harris_scale(im2);
[f2,d2] = descriptor(single(im2),r2,c2, s2);
% Show images with scatter plot on each image for the features
% Note: Images must be same size
figure;
imshow([im1,im2]);
hold on;
scatter(f1(1,:), f1(2,:), f1(3,:), [1,0,0]);
hold on;
scatter(size(im1,2)+f2(1,:), f2(2,:), f2(3,:), [1,0,0]);
drawnow;%Update figure windows and process callbacks
% Create two arrays containing the points location in both images
match1 = [];
match2 = [];
%% basic matching
[matches, scores] = vl_ubcmatch(d1, d2, 1.5); %For each descriptor in da, vl_ubcmatch finds the closest descriptor in db 
%The index of the original match and the closest descriptor is stored in each column of matches
% the distance between the pair is stored in scores
% Matches also can be filtered for uniqueness by passing a third parameter to vl_ubcmatch which specifies a threshold. 
% Here, the uniqueness of a pair is measured as the ratio of the distance between the best matching keypoint and the distance to the second best one
match1 = f1(:,matches(1,1:threshold)); % index of each match--> index of each feature//f contains all the key points
match2 = f2(:,matches(2,1:threshold));
line([match1(1,:);size(im1,2)+match2(1,:)],[match1(2,:);match2(2,:)], 'Color','b');
drawnow;

% The following code is an alternative to vl_ubcmatch. 
% It works equally well.

% For-loops are horrible, but matrix operations can run out of memory
% for fn1=1:size(d1,2)
%     bestmatch = [0 0];
%     bestdis = Inf;
%     %secbestmatch = [0 0];
%     secbestdis = Inf;
%     for fn2=1:size(d2,2)
%         desc1 = d1(:,fn1);
%         desc2 = d2(:,fn2);
%         dif = sqrt(sum((desc1-desc2).^2));
%         
%         % 
%         if dif<threshold
%             if secbestdis>dif
%                 if bestdis>dif
%                     secbestdis=bestdis;
%                     bestdis=dif;
%                     bestmatch=[fn1 fn2];
%                 else
%                     secbestdis = dif;
%                 end
%             end
%         end
%     end
% 
%     % Lowe, D. G., ?Distinctive Image Features from Scale-Invariant
%     % Keypoints?
%     % Reject matches where the distance ratio is greater than 0.8
%     if (bestdis/secbestdis)<0.8
%         crtf1 = f1(:,bestmatch(1));
%         crtf2 = f2(:,bestmatch(2));
%         line([crtf1(1);size(im1,2)+crtf2(1)], [crtf1(2);crtf2(2)]);
%         match1 = [match1, crtf1];
%         match2 = [match2, crtf2];
%         drawnow;
%     end
%       
%     
% end

end
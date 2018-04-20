function findmatches(im1,im2,N)
[frames1, desc1]=vl_sift(im1);
[frames2, desc2]=vl_sift(im2);
[matches, scores] = vl_ubcmatch(desc1,desc2);
% The index of the original match and the closest descriptor is stored in each column 
% of matches and the distance between the pair is stored in scores
% Matches also can be filtered for uniqueness by passing a third parameter to vl_ubcmatch which specifies a threshold. 
% Here, the uniqueness of a pair is measured as the ratio of the distance between
% the best matching keypoint and the distance to the second best one
figure;
imshow([im1,im2]);
hold on;
% scatter(frames1(1,:), frames1(2,:), frames1(3,:), [1,0,0]);
% hold on;
% scatter(size(im1,2)+frames2(1,:), frames2(2,:), frames2(3,:), [1,0,0]);
% drawnow;
[B I]=sort(scores);
threshold=N;
sel=I(1:threshold);
match1 = frames1(:,matches(1,sel)); % index of each match--> index of each feature//f contains all the key points
match2 = frames2(:,matches(2,sel));
line([match1(1,:);size(im1,2)+match2(1,:)],[match1(2,:);match2(2,:)]);
end
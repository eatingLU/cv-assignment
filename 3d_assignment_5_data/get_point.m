function [point1,point2,matches,scores] = get_point(disp_files,img_files,camera,i,j)
% calculate the points in 3d coordinate.
%j = i+1;
subfolder = @(base, sub) [base '/' sub];
merge_file = @(dir) subfolder(dir.folder, dir.name);
disparity1 = read_disparity_image(merge_file(disp_files(i)));
disparity2 = read_disparity_image(merge_file(disp_files(j)));
image1 = imread(merge_file(img_files(i)));
image2 = imread(merge_file(img_files(j)));
img1 = single(rgb2gray(image1));
img2 = single(rgb2gray(image2));
downsample = 4;
[f1 d1] =vl_sift(img1(1:downsample:end,1:downsample:end),'EdgeThresh',10,'PeakThresh',2) ;%   find SIFT features in f_prev
f1(1:2,:) = f1(1:2,:)*downsample;
[f2 d2] =vl_sift(img2(1:downsample:end,1:downsample:end),'EdgeThresh',10,'PeakThresh',2) ;%   find SIFT features in f_now
f2(1:2,:) = f2(1:2,:)*downsample;
[matches, scores] = vl_ubcmatch(d1, d2); %compute matches
point1 = compute_3d(camera,disparity1,round(f1(1,matches(1,:))),round(f1(2,matches(1,:))));
point2 = compute_3d(camera,disparity2,round(f2(1,matches(2,:))),round(f2(2,matches(2,:))));

end


clear all;
close all;
clc;

%% Setting up
subfolder = @(base, sub) [base '/' sub];
merge_file = @(dir) subfolder(dir.folder, dir.name);

img_folder = 'urban/left';
disp_folder = 'urban/disp_gray';

img_files = dir(img_folder);
img_files = img_files(3:end);
disp_files = dir(disp_folder);
disp_files = disp_files(3:end);

for k = 1:numel(disp_files)
    disp_files(k).folder = disp_folder;
    img_files(k).folder = img_folder;
end

%% Load dataset
load('camera')
load('ransac_data');
% contains a 1x99 struct with the name frames:
% frames(i).image_index: index to image img_files
% frames(i).features.prev: matched image features in image prev (k-1)
% frames(i).features.now:  matched image features in image now k

%% Robust egomotion estimation
% HINT: you could use your own function ... from last week assignment
% or you could use the function find_transform(..) in this repository. Example
% usage: [rot,trans] = find_transform(q,p)
% The function return optimal transform q = rot*p + trans;
TRAN=zeros(4,4,length(frames));
for k = 1:length(frames)
    % Get features now and features prev
    % Get 2d points from dataset
    unow = round(frames(k).features.now(1,:));
    vnow = round(frames(k).features.now(2,:));
    uprev = round(frames(k).features.prev(1,:));
    vprev = round(  frames(k).features.prev(2,:));
    
    % Get 3d points from 2D
    disparity_prev = read_disparity_image(merge_file(disp_files(frames(k).image_index.prev)));
    disparity_now = read_disparity_image(merge_file(disp_files(frames(k).image_index.now)));
    points_prev = compute_3d(camera, disparity_prev, uprev, vprev);
    points_now = compute_3d(camera, disparity_now, unow, vnow);
    
    switch 'all'
        case 'all'
            %% Question 1a
            [rot,trans] = find_transform(points_now,points_prev);
            T =[rot trans;zeros(1,size(rot,2)) ones(1,size(1,size(trans,2)))];
            TRAN(:,:,k) =T
            
        case 'ransac'
            %% Question 1e
            
            error_rate = inf;
            for  iteration = 1:300
                subset = vl_colsubset(1:length(points_now),4);  %随机选取匹配点对
                p_p = [];
                p_n = [];
                for i = 1:4
                    p_p = [p_p points_prev(:,subset(i))];
                    p_n = [p_n points_now(:,subset(i))];
                end
                %T = cal_r_t2(p_p,p_n);
                [rot, trans] = find_transform(p_n,p_p) ;
                T =[rot trans ;zeros(1,size(rot,2)) ones(1,size(1,size(trans,2)))];
                error = 0;
                point_index = [];
                for index = 1: length(points_prev)
                    pn1 =T*[points_prev(:,index); 1];
                    distance = sqrt(sum((pn1(1:3)-points_now(:,index)).^2));
                    if distance >0.2
                        error = error+1;
                        point_index=[point_index index];
                    end
                end
                rate_now = error/length(points_prev);
                if  error_rate > rate_now
                    error_rate = rate_now;
                    transform = T;
                    point_wrong = point_index;
                end
            end
            TRAN(:,:,k) = transform;
    end
    x = [0 0 0 1]';
    path=x;
    for i = 1:length(frames)
        x = TRAN(:,:,i)^(-1)*x;
        path = [path x];
    end
end

disparity1 = read_disparity_image(merge_file(disp_files(frames(1).image_index.prev)));
image1 = imread(merge_file(img_files(1)));
draw_path_in_pointcloud(camera, disparity1, image1, path(1:3,:))


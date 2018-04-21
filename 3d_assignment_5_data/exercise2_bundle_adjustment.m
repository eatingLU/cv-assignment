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
load('camera');
load('bundle_adjustement_data.mat');
Camera = [camera.intrinsic.fx,0, camera.intrinsic.u0,0;
    0,camera.intrinsic.fy,camera.intrinsic.v0,0;
    0,0,1,0];
%load 3D points
ddd = ba_data.points3d;

%set the number of frames
ba_data.nr_poses = 10;
p={1,ba_data.nr_poses};
%% Tip 1: Start with running only on subset of the data by setting:
% ba_data.nr_poses = 2; %<-- Uncomment this to run on smaller trajectory

%% Write funciton that maps ba_data.points3d to image plane

% Question 2a
% Write function that maps the 3d poitns to the image of pose i: [u,v] = map2image(P,p,camera)



for t = 1:ba_data.nr_poses
    Q = ba_data.frame(t).indices_features;
    
    [e,f] = size(Q);
    point = [];
    for r = 1:f
        
       %select points according to the indices_features
        point(:,r) = ddd(:,Q(1,r));
        P = point;
        
    end
    p = ba_data.frame(t).pose;
    % compute u,v
    [u,v] = map2image(P,p,camera);
    U{1,t} = u;
    V{1,t} = v;
end

%%
% Question 2b

%this code is to store all the poses in to a large vector
poses_b = [];
for i = 1:ba_data.nr_poses
    poses_b(:,:,i) = double(ba_data.frame(i).pose); 
end
pose_vec_b = [];
for i = 1:ba_data.nr_poses
    for j = 1:4
        pose_vec_b = [pose_vec_b poses_b(j,:,i)];
    end
end
 

%
%%
% %Question 2c

% This part is to put 3D points in to the vector for the optimize
% procedures.
 poses = [];
for i = 1:ba_data.nr_poses
    poses(:,:,i) = double(ba_data.frame(i).pose);
end
pose_vec = [];
for i = 1:ba_data.nr_poses
    for j = 1:4
        pose_vec = [pose_vec poses(j,:,i)];
        PV = pose_vec;
    end
end
pose_vec = PV;
%add 3D points to the vector.
point_3d = ba_data.points3d;
[a,b] = size(point_3d);
for i = 1:b
    point(:,i) = point_3d(:,i);
    P = point;
    P_T = ones(4,b);
    P_T(1:3,i) = P(:,i);
    pose_vec = [pose_vec P_T(:,i)'];
end
% for i = 1:ba_data.nr_poses
%     
%     Q = ba_data.frame(i).indices_features;
%    
%     
%     point = [];
%     [e,f] = size(Q);
% 
%     for r = 1:f
%         point(:,r) = ddd(:,Q(1,r));
%       
%         P = point;
%         P_T = ones(4,f);
%         % homogeneous coordinate
%         P_T(1:3,r) = P(:,r);
%         
%        pose_vec = [pose_vec P_T(:,r)'];
%     end
   X = pose_vec;
% end
% [e,error] = compute_reprojection_error(X,ba_data,camera);
%% 2c+2d
%This part is to compute and optimized the error;
[rmse0,rmse1,X1] = optimize_reprojection_error(X, ba_data, camera);
%% 2e
%% Plot Results
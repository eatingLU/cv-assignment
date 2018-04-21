load('ransac_data.mat');
clear all;
subfolder = @(base, sub) [base '/' sub];
merge_file = @(dir) subfolder(dir.folder, dir.name);
img_folder = 'urban/left';
disp_folder = 'urban/disp_gray';
img_files = dir(img_folder);
img_files = img_files(3:end);
disp_files = dir(disp_folder);
disp_files = disp_files(3:end);
disparity1 = read_disparity_image(merge_file(disp_files(1)));
image1 = imread(merge_file(img_files(1)));
load('camera');
TK = [];
tt = 1;
path=[];
%************part 2*******************
for i = 1:size(img_files)-1

    [P1,P2,matches, scores]=get_point(disp_files,img_files,camera,i,i+1);%calculate the corresponding poinds and matches
    T = cal_r_t2(P1,P2); %calculat transform between two frames
    tt =T*tt;
    TK = [TK {tt}];
    x_init = [0 0 0 1]';
    path = [path ,tt*x_init];
end
path_final = [x_init,path];% final result of the points
draw_path_in_pointcloud(camera, disparity1, image1, path(1:3,:))
save('TK','TK');
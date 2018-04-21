poses = [];
for i = 1:ba_data.nr_poses
    poses(:,:,i) = double(ba_data.frame(i).pose); 
end
pose_vec = [];
for i = 1:ba_data.nr_poses
    for j = 1:4
        pose_vec = [pose_vec poses(j,:,i)];
    end
end
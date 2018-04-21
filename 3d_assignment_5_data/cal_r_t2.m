function  T = cal_r_t2(point1,point2)
%calculation the transformation between each two frames.
%point1 and point2 are 3 x N matrix.
p1= point1;
p2 = point2;
index1 = find(isnan(p1(1,:)));
index2 = find(isnan(p2(1,:)));
index = unique([index1, index2]);
p1(:,index) = [];% remove the NaN in p1 and p2
p2(:,index) = [];
p1_ave = mean(p1,2);% use the algorithm introduced on the slices to calculate the transform
p2_ave = mean(p2,2);
xi = p1- p1_ave;
yi = p1- p2_ave;
S = xi*eye(size(xi,2))*yi';
[U,~,V]=svd(S);
R = V*[eye(size(V,2)-1) zeros(size(V,1)-1,1) ;zeros(1,size(V,2)-1) det(V*U') ]*U';
t = p1_ave - R*p2_ave;
T =[R t;zeros(1,size(R,2)) ones(1,size(1,size(t,2)))];
end




clear all;
load('question3.mat');
load('Calib_Results_stereo.mat');
%********************left->a; right->b
xL=fa([1 2],matches(1,:));
xR=fb([1 2],matches(2,:));
[XL, XR] = stereo_triangulation(xL, xR, om, T, fc_left, cc_left, kc_left, alpha_c_left,fc_right, cc_right, kc_right, alpha_c_right);

figure(1)
scatter3(XR(1,:),XR(2,:),XR(3,:),'r');
title('right-3D')
xlabel('X')
ylabel('Y')
zlabel('Z')
figure(2)
scatter3(XL(1,:),XR(2,:),XR(3,:),'b')
title('left-3D')
xlabel('X')
ylabel('Y')
zlabel('Z')
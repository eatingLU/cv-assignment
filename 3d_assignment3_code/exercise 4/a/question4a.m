clear all
load('Calib_Results_stereo_rectified.mat');
load('D_M.mat');
m = imread('left_rect_chessboard.jpg');
TX = [0 -T_new(3) T_new(2); T_new(3) 0 -T_new(1); -T_new(2) T_new(1) 0];
E = R_new * TX;
F = (KK_left_new^(-1))' * E * (KK_right_new)^(-1);
xL = [];
xR = [];
m_gray = rgb2gray(m);
for i = size(m,1):(-1):1
     for j = size(m,2):(-1):1
      if  d_best(i,j) == 0
          break;
      else
           xL=[xL [j;i]];
          xR =[xR [j+d_best(i,j);i]];
      end
     end
end
[XL,XR] = stereo_triangulation( xL,xR , om_new, T_new, fc_left_new, cc_left_new, kc_left_new, alpha_c_left_new, fc_right_new, cc_right_new, kc_right_new, alpha_c_right_new);

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
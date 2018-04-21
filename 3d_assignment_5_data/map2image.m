function [u,v] = map2image(P,p,camera)
[m,n] = size(P);

q = [0 0 1 0;
    -1 0 0 0;
    0 -1 0 0;
    0 0 0 1];
Camera = [camera.intrinsic.fx,0, camera.intrinsic.u0;
    0,camera.intrinsic.fy,camera.intrinsic.v0;
    0,0,1];
%rotation matrix
rotmat = [cos(camera.extrinsic.pitch) 0  sin(camera.extrinsic.pitch)
    0 1 0
    -sin(camera.extrinsic.pitch) 0 cos(camera.extrinsic.pitch)];
offset = [camera.extrinsic.x;
    camera.extrinsic.y;
    camera.extrinsic.z];
Textrinsic = [rotmat, offset; zeros(1,3), 1] * q ;

%compute camera coordinate
    for i = 1:n
        point_total = ones(4,n);
        point_total(1:3,i) = P(:,i);
        point_v_total(:,i) = inv(p)*point_total(:,i);
        point_cc_total(:,i) = inv(Textrinsic)*point_v_total(:,i);
        xCamt(1,i) = point_cc_total(1,i);
        yCamt(1,i) = point_cc_total(2,i);
        zCamt(1,i) = point_cc_total(3,i);
    end
    %compute image coordinate
    u = xCamt./(zCamt/camera.intrinsic.fx)+camera.intrinsic.u0;
    v = yCamt./(zCamt/camera.intrinsic.fy)+camera.intrinsic.v0;
    


end

function [rmse0,rmse1,X] = optimize_reprojection_error(X, ba_data, camera)

if nargout == 1
    % Only return reprojection error
    
    % Question 2b:
    [~,rmse0] = compute_reprojection_error(X);
else
    [~,rmse0] = compute_reprojection_error(X);
    opts = optimoptions('fminunc', 'Display', 'iter', 'UseParallel', true, 'MaxFunctionEvaluations', 1e5);
    x = fminunc(@compute_reprojection_error,X,opts);
    [~,rmse1] = compute_reprojection_error(x);% Full bundle adjustment
    
    % Question 2c
    % * Compute initial rmse error
    % * Run full bundle adustment
    % * Compute final rmse error
    
    % ...
    % ...
end
%%

    function [e,rmse] = compute_reprojection_error(X)
        n = ba_data.nr_poses;
        %select poses from vector X
        start_point = 1;
        for i = 1:n
            p_r = [];
            p_r(1,:) = X(start_point:start_point+15);
            pose_r{1,i} = p_r(1,:);
            start_point = start_point+16;
        end
        %put pose vector into matrix
        for i = 1:n
            pose_v =[];
            pose_v = pose_r{1,i};
            [aa,bb] = size(pose_v);
            st = bb/4;
            s_point = 1;
            pose_rec = [];
            for j = 1:st
                pose_rec(:,j) = pose_v(1,s_point:s_point+3);
                s_point = s_point+4;
            end
            POSE_REC{1,i} = pose_rec(1:4,:);
        end
        %choose 3d points
        p_poses = 16*n;
        startpoint = n*16+1;
        
        num_sel = 200*4;
        D3_vec(1,:) = X(1,startpoint:startpoint+num_sel-1);
        
        
   % seperate all the points
        
        D3 = D3_vec;
        [h,k] = size(D3);
        s_t = k/4;
        sp = 1;
        ddd = [];
        for j = 1:s_t
            ddd(:,j) = D3(sp:sp+3)';
            sp = sp+4;
        end
        
        
        %      use the points to get u and v
        for t = 1:n
            Q = ba_data.frame(t).indices_features;
            
            [e,f] = size(Q);
            point = [];
            for r = 1:f
                
                %select points according to the indices_features
                point(:,r) = ddd(:,Q(1,r));
                P = point(1:3,:);
                
            end
            p =POSE_REC{1,t};
            % compute u,v
            [u,v] = map2image(P,p,camera);
            U1{1,t} = u;
            V1{1,t} = v;
            u = U1{1,t};
            v = V1{1,t};
            u1 = ba_data.frame(t).feature_locations_px(1,:);
            v1 = ba_data.frame(t).feature_locations_px(2,:);
            s = (u-u1).^2+(v-v1).^2;
            ss(1,t)=sum(s(:));
        end
        
        
        %         for i = 1:n
        %             p = POSE_REC{1,i}
        %             PP = DDD{1,i};
        %             P =PP(1:3,:);
        %             [u,v] = map2image(P,p,camera);
        %             U{1,i} = u;
        %             V{1,i} = v;
        %             u = U{1,i};
        %             v = V{1,i};
        %             u1 = ba_data.frame(i).feature_locations_px(1,:);
        %             v1 = ba_data.frame(i).feature_locations_px(2,:);
        %             %calculate the error for each u and v
        %             s = (u-u1).^2+(v-v1).^2;
        %             ss(1,i)=sum(s(:));
        %         end
        %sum up for all poses
        sss = sum(ss(:));
        %calculate the totle number of points
        for i =1:n
            [a,b] = size(ba_data.frame(i).indices_features);
            s_p(1,i) = b;
            
        totle_nr_point = sum(s_p(:));
        end
        rmse = sqrt(sss/totle_nr_point);
        e = sss./totle_nr_point;
    end
if nargout > 1 % Only output rmse if 2 output arguments are requested
    % Compute rmse error
    % rmse = ...
end
end




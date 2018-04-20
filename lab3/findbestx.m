function [bestx]=findbestx(match1, match2)
iterations=50;
miniterations=5;
threshold=10;
P=3;
bestx=zeros(6,1);
i=0;
nc=size(match1,2);
max=0;
while(i<iterations || i<miniterations)
    % take P matches
    perm=randperm(size(match1,2));
    seed=perm(1:P);
    
    % fit the model
     b = [match2(1,seed) match2(2,seed)];
     A = [match1(1:2,seed)', zeros(P , 2) ones(P, 1) ,zeros(P ,1);...
        zeros(P , 2), match1(1:2,seed)', zeros(P ,1), ones(P, 1)];
     x = pinv(A)* b';
    
     % determine inliers
     A = [match1', zeros(nc , 2) ones(nc, 1) ,zeros(nc ,1);...
        zeros(nc , 2), match1', zeros(nc ,1), ones(nc, 1)];
     permb = A*x;
     permb = reshape(permb, nc, 2)';
     inliers = find(sqrt(sum((match2-permb).^2)) <threshold); % contains the index
     
     % refit the model
     nnc = size(inliers,2);
     A = [match1(:,inliers)', zeros(nnc , 2), ones(nnc, 1) , zeros(nnc ,1);...
        zeros(nnc , 2), match1(:,inliers)', zeros(nnc ,1), ones(nnc, 1)];
     b = [match2(1,inliers) match2(2,inliers)];
     x = pinv(A)* b';
     
     % determin inliers
     A = [match1', zeros(nc , 2) ones(nc, 1) ,zeros(nc ,1);...
        zeros(nc , 2), match1', zeros(nc ,1), ones(nc, 1)];
     permb = A*x;
     permb = reshape(permb, nc, 2)';
     inliers_refit = find(sqrt(sum((match2-permb).^2)) <threshold); 
     if size(inliers_refit,2)>size(inliers,2)
         inliers=inliers_refit;
     end
     
     % save the best x
     if size(inliers,2)>max
         max=size(inliers,2);
         bestx=x;
     end
   
     i=i+1;
end
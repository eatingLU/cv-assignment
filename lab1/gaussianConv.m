function imOut = gaussianConv(image , sigma_x , sigma_y,r)
[m,n]=size(image);
im=image;
for i=1:m
    im_x(i,:)=conv2(gaussian(sigma_x,r),im(i,:));
end
for j=1:n
    im_y(:,j)=conv2(gaussian(sigma_y,r),im(:,j)');
end
imOut=(im_x(:,(r+1):(300+r))+im_y((r+1):(300+r),:))/2;
end

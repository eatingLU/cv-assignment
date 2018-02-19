function imOut = gaussianConv(image , sigma_x , sigma_y)
[m,n]=size(image);
im=image;
for i=1:m
    im_x(i,:)=conv2(gaussian(sigma_x),im(i,:));
end
for j=1:n
    im_y(:,j)=conv2(gaussian(sigma_y),im(:,j)');
end
imOut=(im_x(:,8:307)+im_y(8:307,:))/2;
end

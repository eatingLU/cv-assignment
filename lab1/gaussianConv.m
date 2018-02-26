function imOut = gaussianConv(image , sigma)
[m,n]=size(image);
im=image;
for i=1:m
    im_x(i,:)=conv2(gaussian(sigma),im(i,:));
end
for j=1:n
    im_y(:,j)=conv2(gaussian(sigma),im(:,j)');
end
imOut=(im_x(:,(sigma+1):(300+sigma))+im_y((sigma+1):(300+sigma),:))/2;
end

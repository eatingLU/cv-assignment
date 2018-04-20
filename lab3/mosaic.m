function imgout = mosaic(varargin)
im1=varargin{1};
im2=varargin{2};
% Find corners from image
w = size(im1,2);
h = size(im1,1);
corners = [1 1 1; w 1 1; 1 h 1; w h 1]';% expended corner coordinates (x,y,1)
A(:,:,1)=eye(3);
% First image is not transformed
[frames1, desc1]=vl_sift(im1);
[frames2, desc2]=vl_sift(im2);
matches=vl_ubcmatch(desc1,desc2);
match1=frames1(1:2,matches(1,:));
match2=frames2(1:2,matches(2,:));
x=findbestx(match2, match1);
% Make the affine transformation
A(:,:,2)= [x(1) x(2) x(5); x(3) x(4) x(6); 0 0 1];
% Add the corners of this image
w = size(im2,2);
h = size(im2,1);
corners=[corners, A(:,:,2)*[1 1 1; w 1 1; 1 h 1; w h 1]'];
% Find size of output image
minx = floor(min(corners(1,:)));
maxx = ceil(max(corners(1,:)));
miny = floor(min(corners(2,:)));
maxy = ceil(max(corners(2,:)));
% Output image
imgout = zeros(maxy-miny+1, maxx-minx+1, nargin);

% Output image coordinate system
xdata = [minx, maxx];
ydata = [miny, maxy];

% Transform each image to the coordinate system
 for i=1:2
     tform = maketform('affine', A(:,:,i)');
     imgout(:,:,i)= imtransform(varargin{i}, tform, 'bicubic', 'XData', xdata, 'YData', ydata, 'FillValues', NaN);
     i=i+1;
 end
% Different blending methods
% nanmedian seems to be the most stable for longer sequences of images
 imgout = nanmean(imgout,3);
end
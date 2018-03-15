function [r, c] = harris(im, sigma)
% inputs: 
% im: double grayscale image
% sigma: integration-scale
% outputs:  The row and column of each point is returned in r and c
% figure(1)
% subplot(221)
% imshow(im,[])
% This function finds Harris corners at integration-scale sigma.
% The derivative-scale is chosen automatically as gamma*sigma

gamma = 0.7; % The derivative-scale is gamma times the integration scale
derivative_scale=gamma*sigma;
% Calculate Gaussian Derivatives at derivative-scale
% Hint: use your previously implemented function in assignment 1 
Ix =  ImageDerivatives(im , derivative_scale , 'x'); % partial derivative with respect to x
Iy =  ImageDerivatives(im , derivative_scale , 'y');
% Allocate an 3-channel image to hold the 3 parameters for each pixel
M = zeros(size(Ix,1), size(Ix,2), 3);

% Calculate M for each pixel
M(:,:,1) = Ix.*Ix;
M(:,:,2) = Ix.*Iy;
M(:,:,3) = Iy.*Iy;

% Smooth M with a gaussian at the integration scale sigma.
M = imfilter(M, fspecial('gaussian', ceil(sigma*6+1), sigma), 'replicate', 'same');
%The output array is the same size as the input  array.
% 'replicate'  Input array values outside the bounds of the array
% are assumed to equal the nearest array border value.

% Compute the cornerness R
[m, n]=size(Ix);
k=0.05;
for i=1:m
    for j=1:n
        m=[M(i,j,1), M(i,j,2); M(i,j,2), M(i,j,3)];
        t(i,j) = trace(m);
        d(i,j)= det(m);
        R(i,j)= d(i,j)-k*t(i,j).^2;
    end
end
% subplot(222)
% imshow(R)

% Set the threshold 
threshold = 0.01*max(max(R));

% Find local maxima
% Dilation will alter every pixel except local maxima in a 3x3 square area.
% Also checks if R is above threshold
R = ((R>threshold) & ((imdilate(R, strel('square', 3))==R))) ; %.* sigma;

% Display corners
% subplot(223)
% imshow(R,[])

% Return the coordinates
[r,c] = find(R==1);
% subplot(224)
% imshow(im)
% hold on
% scatter(c, r,'r.')

end
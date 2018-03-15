function [rows, cols, sigmas] = harris_scale(im, mode)
% Scale invariant implementation of harris detector
% Uses Laplacian to detect corners on multiple scales
% mode can be either LoG or DoG.
    if nargin < 2
        mode = 'LoG';
    end
    sigma_array = 1 * 1.2 .^ (0:12);% scale space construct
    numScales = size(sigma_array, 2);
   
    corners = zeros(0, 3); % Rows, corners, scale_num
    %start index is 0 because of the iteration step end+1
    L = zeros(size(im,1), size(im,2), numScales); % LoG or DoG images
    
    % Compute corners and Laplacian at each scale
    for i=1:numScales
        sigma = sigma_array(i);
        [r,c] = harris(im, sigma);% find the coners in each level
        num_corners = size(r, 1);
        corners(end+1:end+num_corners,:) = [r,c,ones(num_corners, 1)*i];
        % the coners will be stored together, columns:r,c,ones*i(represent the level number)
        % Calculate the scale-normalized LoG
        if mode == 'LoG'
            L(:,:,i) = imfilter(im, sigma^2 * fspecial('log', 2*ceil(3*sigma)+1, sigma), 'replicate', 'same');
        end
    end
    
    if mode == 'DoG'
        L = DoG(im, sigma_array(1), numScales, sqrt(2));%DoG only has one octave
    end
    % then from several LoGs we are going to find maximum within levels
    num_corners = size(corners,1);
    % compute the number of corners in all levels
    lpts = 0; % Number of points that are LoG maxima
    for i = 1:num_corners
       
        r = corners(i, 1);% the index of a corner
        c = corners(i, 2);
        s = corners(i, 3);% store the scale 
        
        % Check if we're at an extremum LoG value in scale
        if s > 1 && s < numScales % compare with the neighbours above and below the current image
            if L(r,c,s)<= L(r,c,s-1) && L(r,c,s) >= L(r,c,s+1) % 1 by 3 search window
                % the corresponding pixel value in the laplacian image
                continue
                % Pass control to the next iteration of FOR or WHILE loop
            end
            if L(r,c,s) >= L(r,c,s-1) && L(r,c,s) <= L(r,c,s+1)
                continue
            end
        else
            continue %only have one neighbour-->give up comparison
        end
        
        % Add the point
        lpts = lpts+1;
        rows(lpts) = r;
        cols(lpts) = c;
        sigmas(lpts) = s;      
    end
    % Return actual scale values, not the indices
    sigmas = sigma_array(sigmas); % find the corresponding sigma value

end
function [f,d] = descriptor(im, r, c, s)
% Create sift descriptors for given corners
% Orientation is computed by vl_sift
fc = [c; r; 2*s+1; zeros(size(s))];% bypass the detector and compute the descriptor on custom frames
% c,r-->the center of the frame
% 2*s+1-->the dim of blurring window
% zero-->Custom frame with computed orientations.
[f,d] = vl_sift(im,'frames',fc, 'orientations') ; %D is the descriptor of the corresponding frame in f, 128-dimensional vector, 4*4*8
end
function [panoImg] = imageStitching(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image
    if nargin < 2
        img1 = imread('../data/incline_L.png');
        img2 = imread('../data/incline_R.png');
    end

    out_size = [600, 1577];

    warp_im = warpH(img2, H2to1, out_size);
    [panoImg] = blend(img1, warp_im);
    % imshow(warp_im);
    imshow(panoImg);

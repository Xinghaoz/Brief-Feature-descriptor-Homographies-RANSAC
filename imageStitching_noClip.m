function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image
%
% To prevent clipping at the edges, we instead need to warp both image 1 and image 2 into a common third reference frame
% in which we can display both images without any clipping.

    Width = 1200;

    [h1, w1, channel1] = size(img1);
    [h2, w2, channel2] = size(img2);

    img2_corners = [1,  1,  w2, w2;
                    1,  h2, 1,  h2;
                    1,  1,  1,  1];

    img2_whole = H2to1 * img2_corners;

    img2Norm = repmat(img2_whole(3, :), 3, 1);

    img2_whole = img2_whole ./ img2Norm;

    top = floor(min(1, min(img2_whole(2, :))));
    bottom = floor(max(h1, max(img2_whole(2, :))));
    left = floor(min(1, min(img2_whole(1, :))));
    right = floor(max(w1, max(img2_whole(1, :))));

    Height = floor(Width * (bottom - top) / (right-left));
    out_size = [Height Width];

    Trans = [   1  0   -left;
                0  1   -top;
                0  0   1];

    Scale = [ (Width / (right - left))  0                           0;
            0                         (Height / (bottom - top))   0;
            0                         0                           1];

    M = Scale * Trans;

    warp_im1 = warpH(img1, M, out_size);
    warp_im2 = warpH(img2, M * H2to1, out_size);

    panoImg = blend(warp_im1, warp_im2);
    imshow(panoImg);

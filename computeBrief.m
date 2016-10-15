function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareA, compareB)
%%Compute Brief feature
% input
% im - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image patch and are each nbits x 1 vectors
%
% output
% locs - an m x 3 vector, where the first two columns are the image coordinates of keypoints and the third column is
%		 the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of valid descriptors in the image and will vary

    load('parameters.mat')

    halfPatch = floor(patchWidth / 2);
    % halfPatch = 4;
    [a, b, levels_size] = size(GaussianPyramid);

    % Find valid keypoints.
    locs = locsDoG(locsDoG(:,1) > halfPatch & ...
        locsDoG(:,1) < b - halfPatch & ...
        locsDoG(:,2) > halfPatch & ...
        locsDoG(:,2) < a - halfPatch, :);

    [m, ~] = size(locs);
    desc = [];

    for i = 1 : m
        x = locs(i, 2);
        y = locs(i);

        xStart = x - 4;
        xEnd = x + 4;
        yStart = y - 4;
        yEnd = y + 4;

        block = im([xStart:xEnd], [yStart:yEnd]);

        temp = zeros(1,256);
        for j = 1 : nbits
            temp(j) = block(compareA(j)) < block(compareB(j));
        end
        desc = [desc;temp];
    end

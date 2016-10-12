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

    patchWidth = 9;
    nbits = length(compareA);

    halfPatch = floor(patchWidth / 2);
    [a, b, levels_size] = size(GaussianPyramid);

    locs = locsDoG(locsDoG(:,1) > halfPatch & ...
        locsDoG(:,1) < b - halfPatch & ...
        locsDoG(:,2) > halfPatch & ...
        locsDoG(:,2) < a - halfPatch, :);

    [~, levelInds] = ismember(locs(:,3), levels);

    [Xx, Xy] = ind2sub([patchWidth, patchWidth], compareA);
    [Yx, Yy] = ind2sub([patchWidth, patchWidth], compareB);
    Xx = repmat((Xx - halfPatch - 1)', size(locs, 1), 1);
    Xy = repmat((Xy - halfPatch - 1)', size(locs, 1), 1);
    Yx = repmat((Yx - halfPatch - 1)', size(locs, 1), 1);
    Yy = repmat((Yy - halfPatch - 1)', size(locs, 1), 1);

    compX1 = repmat(locs(:, 1), 1, nbits) + Xx;
    compY1 = repmat(locs(:, 2), 1, nbits) + Xy;
    compX2 = repmat(locs(:, 1), 1, nbits) + Yx;
    compY2 = repmat(locs(:, 2), 1, nbits) + Yy;
    compL = repmat(levelInds, 1, nbits);

    comp1 = sub2ind(size(GaussianPyramid), compY1, compX1, compL);
    comp2 = sub2ind(size(GaussianPyramid), compY2, compX2, compL);

    desc = GaussianPyramid(comp1) < GaussianPyramid(comp2);

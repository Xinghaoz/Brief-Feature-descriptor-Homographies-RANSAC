function [locs, desc] = briefLite(im)
% input
% im - gray image with values between 0 and 1
%
% output
% locs - an m x 3 vector, where the first two columns are the image coordinates of keypoints and the third column
% 		 is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors.
%		 m is the number of valid descriptors in the image and will vary
% 		 n is the number of bits for the BRIEF descriptor

    load('parameters.mat')
    load('testPattern')

    [~, ~, channels] = size(im);

    % First RGB -> Grey, Then Grey -> Double!
    if channels > 1
        im = rgb2gray(im);
    end

    im = im2double(im);

    [locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, theta_c, theta_r);

    [locs, desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareA, compareB);

function [matches] = testMatch(im1_origin, im2_origin)
    load('parameters');

    if nargin < 2
        im1_origin = imread('../data/model_chickenbroth.jpg');
        im2_origin = imread('../data/chickenbroth_01.jpg');
    end

    [~, ~, channels1] = size(im1_origin);
    [~, ~, channels2] = size(im2_origin);

    % First RGB -> Grey, Then Grey -> Double!
    if channels1 > 1
        im1_origin = rgb2gray(im1_origin);
    end

    if channels2 > 1
        im2_origin = rgb2gray(im2_origin);
    end

    im1 = im2double(im1_origin);
    im2 = im2double(im2_origin);

    [locs1, desc1] = briefLite(im1);
    [locs2, desc2] = briefLite(im2);

    [matches] = briefMatch(desc1, desc2);

    plotMatches(im1, im2, matches, locs1, locs2);

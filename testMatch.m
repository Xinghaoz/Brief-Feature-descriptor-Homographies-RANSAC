function [matches] = testMatch(im_1_origin, im_2_origin)
    load('parameters');

    if nargin < 2
        im_1_origin = imread('../data/model_chickenbroth.jpg');
        im_2_origin = imread('../data/chickenbroth_01.jpg');
    end

    im_1_double = im2double(im_1_origin);
    im_2_double = im2double(im_2_origin);

    im1 = rgb2gray(im_1_double);
    im2 = rgb2gray(im_2_double);

    % GaussianPyramid_1 = createGaussianPyramid(im1, sigma0, k, levels)
    % GaussianPyramid_2 = createGaussianPyramid(im2, sigma0, k, levels)
    %
    % [DoGPyramid_1, DoGLevels] = createDogPyramid(GaussianPyramid_1, levels);
    % [DoGPyramid_2, DoGLevels] = createDogPyramid(GaussianPyramid_2, levels);
    %
    % PrincipalCurvature_1 = computePrincipalCurvature(DoGPyramid_1);
    % PrincipalCurvature_2 = computePrincipalCurvature(DoGPyramid_2);

    [locsDoG_1, GaussianPyramid_1] = DoGdetector(im1, sigma0, k, levels, theta_c, theta_r);
    [locsDoG_2, GaussianPyramid_2] = DoGdetector(im2, sigma0, k, levels, theta_c, theta_r);

    [locs1, desc1] = briefLite(im1);
    [locs2, desc2] = briefLite(im2);

    [matches] = briefMatch(desc1, desc2);

    plotMatches(im1, im2, matches, locs1, locs2);

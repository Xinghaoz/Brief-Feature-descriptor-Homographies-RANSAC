function [locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, theta_c, theta_r)

GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);

[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);

PrincipalCurvature = computePrincipalCurvature(DoGPyramid);

locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, theta_c, theta_r);

% % Q1.5: Show the img
% imshow(im);
% hold on
% plot(locsDoG(:, 1), locsDoG(:, 2), '.g');

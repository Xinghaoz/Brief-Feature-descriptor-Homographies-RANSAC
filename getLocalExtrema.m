function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature,theta_c, theta_r)
%%Detecting Extrema
% inputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a DoG response magnitude above this threshold
% th_r - remove any edge-like points that have too large a principal curvature ratio
% output
% locsDoG - N x 3 matrix where the DoG pyramid achieves a local extrema in both scale and space, and also satisfies the two thresholds.

Extremums = abs(DoGPyramid) > theta_c & PrincipalCurvature < theta_r & (imregionalmax(DoGPyramid, 26) | imregionalmin(DoGPyramid, 26));

[Y, X, L] = ind2sub(size(DoGPyramid), find(Extremums));
locsDoG = [X, Y, DoGLevels(L)'];

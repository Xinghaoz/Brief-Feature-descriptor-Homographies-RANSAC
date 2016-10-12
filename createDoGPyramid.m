function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)
%%Produces DoG Pyramid
% inputs
% Gaussian Pyramid - A matrix of grayscale images of size (size(im), numel(levels))
% levels - the levels of the pyramid where the blur at each level is
% outputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid created by differencing the Gaussian Pyramid input

    [a,b,levels_size] = size(GaussianPyramid);
    DoGLevels = levels(1 : levels_size - 1);
    DoGPyramid = zeros(a,b,levels_size - 1);

    for i = 1: levels_size - 1
        DoGPyramid(:,:,i) = GaussianPyramid(:,:,i + 1) - GaussianPyramid(:,:,i);
    end

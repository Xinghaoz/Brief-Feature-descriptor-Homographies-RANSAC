function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% inputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each point contains the curvature ratio R for the
% 					   corresponding point in the DoG pyramid

    [a,b,levels_size] = size(DoGPyramid);
    PrincipalCurvature = zeros(a,b,levels_size);

    for i = 1 : levels_size
        [Dx, Dy] = gradient(DoGPyramid(:, :, i));
        [Dxx, Dxy] = gradient(Dx);
        [Dyx, Dyy] = gradient(Dy);

        PrincipalCurvature(:, :, i) = (Dxx + Dyy).^2 ./ (Dxx .* Dyy - Dxy .* Dyx);
    end

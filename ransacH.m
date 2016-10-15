function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% input
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
% output
% bestH - homography model with the most inliers found during RANSAC

    if ~exist('nIter', 'var') || isempty(nIter)
    nIter = 77;
    end

    if ~exist('tol', 'var') || isempty(tol)
    tol = 0.7;
    end

    p1 = locs1(matches(:, 1), 1:2);
    p2 = locs2(matches(:, 2), 1:2);

    [n, ~, ~] = size(p1);

    p1Norm = p1 ./ repmat(sum(p1), n, 1);

    bestH = zeros(3,3);

    minDistance = tol;
    for i = 1 : nIter
        sample = randperm(n,4);
        p1Sample = p1(sample,:);
        p2Sample = p2(sample,:);

        H2to1 = computeH(p1Sample,p2Sample);


        % For test
        % [panoImg] = imageStitching_noClip(img1, img2, H2to1);

        p1Compare = zeros(n, 2);
        p1Compare(:,1) = (H2to1(1,1) .* p2(:,1) + H2to1(1,2) .* p2(:, 2) + H2to1(1,3)) ./ ...
                         (H2to1(3,1) .* p2(:,1) + H2to1(3,2) .* p2(:, 2) + H2to1(3,3));

        p1Compare(:,2) = (H2to1(2,1) .* p2(:,1) + H2to1(2,2) .* p2(:, 2) + H2to1(2,3)) ./ ...
                         (H2to1(3,1) .* p2(:,1) + H2to1(3,2) .* p2(:, 2) + H2to1(3,3));

        % Normalize
        norm = repmat(sum(p1Compare), n, 1);
        p1Compare = p1Compare ./ norm;
        % normal

        % p1Compare = [p1, ones(n, 1)] * H2to1;

        diff = p1Norm - p1Compare;
        temp = [diff(:,1).^2, diff(:,2).^2];
        edcDistance = sum(sqrt(temp(:,1) + temp(:,2)));

        if edcDistance < minDistance
            minDistance = edcDistance;
            bestH = H2to1;
        end

    end

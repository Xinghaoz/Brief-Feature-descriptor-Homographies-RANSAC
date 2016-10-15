function [im3] = generatePanorama(im1, im2)

    [locs1, desc1] = briefLite(im1);
    [locs2, desc2] = briefLite(im2);

    [matches] = briefMatch(desc1, desc2);

    p1 = locs1(matches(:, 1), 1:2);
    p2 = locs2(matches(:, 2), 1:2);

    H2to1 = computeH(p1,p2);

    [bestH] = ransacH(matches, locs1, locs2, 77, 0.25);

    [im3] = imageStitching_noClip(im1, im2, bestH);
    imshow(im3);
    title('Final panorama view (After using RANSAC)')

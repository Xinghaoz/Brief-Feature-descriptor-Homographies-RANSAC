function H2to1 = computeH(p1,p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation

    % Test points for img1
    % 656 477
    % 799 320
    % 917 326
    % 480 120
    %
    % Test points for img2
    % 346 526
    % 474 364
    % 574 366
    % 149 163
    
    [n, ~] = size(p1);

    A = zeros(2 * n, 9);

    for i = 1 : n
        A((i - 1) * 2 + 1,:) = [p2(i,1), p2(i,2), 1, 0, 0, 0, -p1(i,1) * p2(i,1), -p1(i,1) * p2(i,2), -p1(i,1)];
        A((i - 1) * 2 + 2,:) = [0, 0, 0, p2(i,1), p2(i,2), 1, -p1(i,2) * p2(i,1), -p1(i,2) * p2(i,2), -p1(i,2)];
    end

    [V, ~] = eig(A' * A);
    h = V(:, 1);
    H2to1 = reshape(h, 3, 3)';

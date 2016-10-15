function [panoImg] = blend(img1, img2)
    % See write-up page 15
    [h1, w1, channel1] = size(img1);
    [h2, w2, channel2] = size(img2);
    h = min(h1,h2);
    w = min(w1,w2);

    panoImg = uint8(zeros(max(size(img2), size(img1))));
    panoImg(1 : h1, 1 : w1, :) = img1;
    panoImg(1 : h2, 1 : w2, :) = img2;

    mask = sum(img1(1:h, 1:w, :), 3) > sum(img2(1:h, 1:w, :), 3);
    mask = uint8(repmat(mask, 1, 1, size(img1, 3)));

    panoImg(1 : h, 1 : w, :) = img1(1:h, 1:w, :) .* mask + img2(1:h, 1:w, :) .* (1 - mask);

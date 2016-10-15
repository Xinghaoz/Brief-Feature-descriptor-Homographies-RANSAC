function briefRotTest(im_origin)
    if nargin < 1
        im_origin = imread('../data/model_chickenbroth.jpg');
    end

    degrees = linspace(0,360,37);
    [~, degree_size] = size(degrees);

    matches_array = zeros(degree_size, 1);

    [~, desc_origin] = briefLite(im_origin);
    for i = 1 : degree_size
        im_rotate = imrotate(im_origin, degrees(i));
        [~, desc_rotate] = briefLite(im_rotate);
        [matches] = briefMatch(desc_origin, desc_rotate);
        [num, ~] = size(matches);
        matches_array(i) = num;
    end

    bar(degrees, matches_array);

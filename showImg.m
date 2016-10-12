function showImg(imgs)
    [a,b,levels_size] = size(imgs);
    figure(1);

    for i = 1 : levels_size
        subplot(1,levels_size,i)
        imshow(imgs(:,:,i))
    end

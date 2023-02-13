function im = imPrep(imName)
% 读取图像并转灰度图

    im = imread(imName);
    im = im2double(rgb2gray(im));
end
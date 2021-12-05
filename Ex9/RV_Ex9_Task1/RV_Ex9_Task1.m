% Clear Workspace
clc; clear; close all;

% Load Image
img = imread('..\images\text\text.bmp');

% Main Function
figure;
imshow(binarization(img));
title('binarize');

figure;
imshow(color(img));
title('with original color');

% Functions
function x = binarization(I)
    y = I(:,:,:) < 180;
    x = ~(y(:,:,1) | y(:,:,2) | y(:,:,3));
end

function x = color(I)
    y = I(:,:,:) < 180;
    b = (y(:,:,1) | y(:,:,2) | y(:,:,3));
    x = imcomplement(bsxfun(@times, I, cast(b, 'like', I)));
end
% Clear Workspace
clc; clear; close all;

% Load Image
img_1 = imread('..\images\Cans\colour\closed_1.jpg');
img_2 = imread('..\images\Cans\colour\closed_2.jpg');
img_3 = imread('..\images\Cans\colour\closed_3.jpg');

img_4 = imread('..\images\Cans\colour\opened_1.jpg');
img_5 = imread('..\images\Cans\colour\opened_2.jpg');
img_6 = imread('..\images\Cans\colour\opened_3.jpg');
img_7 = imread('..\images\Cans\colour\opened_4.jpg');
img_8 = imread('..\images\Cans\colour\opened_5.jpg');
img_9 = imread('..\images\Cans\colour\opened_6.jpg');
img_10 = imread('..\images\Cans\colour\opened_7.jpg');
img_11 = imread('..\images\Cans\colour\opened_8.jpg');
img_12 = imread('..\images\Cans\colour\opened_9.jpg');

show(img_1); show(img_2); show(img_3);
show(img_4); show(img_5); show(img_6); show(img_7); show(img_8); show(img_9); show(img_10); show(img_11); show(img_12);


% Functions
function x = grayscale(I)
    x = (I(:,:,1)*0.299 + I(:,:,2)*0.587 + I(:,:,3)*0.114);
end

function x = binarization(I)
    I = imdilate(imerode(I > 50, strel('disk', 3)),strel('disk', 4));
    x = imclose(I, strel('disk',10));
end

function show(I)
    I = binarization(grayscale(I));
    figure;
    imshow(I);
    if (bweuler(I) == 1)
        title("Closed");
    else
        title("Open");
    end
end
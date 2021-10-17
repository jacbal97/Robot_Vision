% Clear Workspace
clc;
close all;
clear;

% Load Images
img_1 = imread('image_1.jpg');
img_2 = imread('image_2.jpg');
img_3 = imread('image_3.jpg');
img_4 = imread('image_4.jpg');

% Show Results
show(img_1);
show(img_2);
show(img_3);
show(img_4);

% Functions
function img = grid(in, div)
    [width, height, ~] = size(in);
    width = floor(width/div);
    height = floor(height/div);
    
    for i=0:1:div-1
        for j=0:1:div-1
           img(width*i+1:width*(i+1), height*j+1:height*(j+1)) = equal(in(width*i+1:width*(i+1), height*j+1:height*(j+1)));
        end
    end
end

function img = slide(in, area)
    [width, height, ~] = size(in);
    for i=floor(area/2):1:width-ceil(area/2)
        for j=floor(area/2):1:height-ceil(area/2)
            img(i-ceil(area/2)+1:i+floor(area/2), j-ceil(area/2)+1:j+floor(area/2)) = equal(in(i-ceil(area/2)+1:i+floor(area/2), j-ceil(area/2)+1:j+floor(area/2)));
        end
    end
    
end

function image = equal(img)
    h = reshape(imhist(img),1,[]);
    w = h/numel(img);
    cs = cumsum(w);
    image = uint8(cs(img+1)*255);
end

function show(img)
    gimg = grid(img,5);
    simg = slide(img,128);

    figure;
    subplot(2,3,1), imshow(img);
    subplot(2,3,2), imshow(gimg);
    subplot(2,3,3), imshow(simg);
    subplot(2,3,4), imhist(img);
    subplot(2,3,5), imhist(gimg);
    subplot(2,3,6), imhist(simg);
end
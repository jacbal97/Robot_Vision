% Clear Workspace
clc;
close all;
clear;

% Read Image
rgb = imread('Lenna.png');
hsv = rgb2hsv(rgb);
gray = rgb2gray(rgb);
[width, height, ~] = size(rgb);

% Picked Value
x = 165;
y = 278;

% Declare Variables
val_rgb = [int32(rgb(165,278,1)), int32(rgb(165,278,2)), int32(rgb(165,278,3))];
val_hsv = [hsv(165,278,1), hsv(165,278,2), hsv(165,278,3)];
val_gray = gray(165,278);

% Tolerance
e_rgb = 40;
e_hsv = 0.12;
e_gray = 10; 

% Images after segmentation
img_rgb = seg_rgb(rgb, val_rgb, e_rgb, width, height);
img_hsv = seg_hsv(hsv, val_hsv, e_hsv, width, height);
img_gray = seg_gray(gray, val_gray, e_gray, width, height);

% Show Results
figure;
subplot(2,2,1), imshow(rgb);
title('Test Image');
subplot(2,2,2), imshow(img_rgb);
title('RGB Segmentation');
subplot(2,2,3), imshow(img_hsv);
title('HSV Segmentation');
subplot(2,2,4), imshow(img_gray);
title('Grayscale Segmentation');

% Functions
function seg_img = seg_gray(img, val, e, height, width)
    for i=1:1:width
        for j=1:1:height
            if (abs(img(i,j) - val) < e)
                seg_img(i,j) = 1;
            else
                seg_img(i,j) = 0;
            end
        end
    end
end

function seg_img = seg_rgb(img, val, e, height, width)
    for i=1:1:width
        for j=1:1:height
            if (sqrt(double(power(int32(img(i,j,1))-val(1),2) + power(int32(img(i,j,2))-val(2),2) + power(int32(img(i,j,3))-val(3),2))) < e)
                seg_img(i,j) = 1;
            else
                seg_img(i,j) = 0;
            end
        end
    end
end

function seg_img = seg_hsv(img, val, e, height, width)
    for i=1:1:width
        for j=1:1:height
            if(sqrt(-2*img(i,j,2)*val(2)*img(i,j,3)*val(3)*cos(img(i,j,1)-val(1)) + power(img(i,j,2),2)*power(img(i,j,3),2) + power(val(2),2)*power(val(3),2) + power(img(i,j,3) - val(3),2)) < e)
                seg_img(i,j) = 1;
            else
                seg_img(i,j) = 0;
            end
        end
    end
end 
% Clear Workspace
clc;
clear;
close all;

% Load Images
img_1 = imread('..\images_2\circle_2.bmp');
img_2 = imread('..\images_2\ellipse_3.bmp');
img_3 = imread('..\images_2\square_3.bmp');
img_4 = imread('..\images_2\dumbbell_1.bmp');

% Main Function
show(img_1, imrotate(img_2,320), img_3, img_4);

% Functions
function x = ratio(I)
    [rows, columns] = find(I);
    
    left = min(columns);
    right = max(columns);
    top = min(rows);
    bottom = max(rows);
    
    axis_x = right-left;
    axis_y = bottom-top;
    
    if (axis_x > axis_y)
        x = axis_x/axis_y;
    else
        x = axis_y/axis_x;
    end
end

function show(I1, I2, I3, I4)
    figure;
    subplot(2,2,1), imshow(I1);
    title("ratio: " + ratio(I1));
    subplot(2,2,2), imshow(I2);
    title("ratio: " + ratio(I2));
    subplot(2,2,3), imshow(I3);
    title("ratio: " + ratio(I3));
    subplot(2,2,4), imshow(I4);
    title("ratio: " + ratio(I4));
end
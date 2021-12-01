% Clear Works
clear;
clc;
close all;

% Load Images
img_1 = imread('..\images_2\circle_2.bmp');
img_2 = imread('..\images_2\ellipse_3.bmp');
%img_3 = imread('..\images_2\circle_3.bmp');
img_4 = imread('..\images_2\square_3.bmp');

mybox(img_1);
mybox(img_2);
%mybox(img_3);
% Functions
function box(I)
    stats = regionprops(I,'BoundingBox');
    fprintf("x1: %g, y1: %g,\tx2: %g, y2: %g\n", stats.BoundingBox(1), stats.BoundingBox(2), stats.BoundingBox(3), stats.BoundingBox(4));
    figure;
    imshow(I);
    hold on
    rectangle('Position', [stats.BoundingBox(1), stats.BoundingBox(2), stats.BoundingBox(3), stats.BoundingBox(4)], 'EdgeColor', 'r');
    hold off;
end

function mybox(I)
    [rows, columns] = find(I);
    
    left = min(columns);
    right = max(columns);
    top = min(rows);
    bottom = max(rows);
    
    fprintf("x1: %g, y1: %g,\tx2: %g, y2: %g\n", left, top, right-left, bottom-top);
    fprintf("Diagonal of feret box: %.2f\n", sqrt((right-left)^2+(bottom-top)^2));
    fprintf("Diameter: %g\n", diam(left, right, top, bottom));
    
    figure;
    hold on;
    imshow(I);
    rectangle('Position', [left, top, right-left, bottom-top], 'EdgeColor', 'r');
    hold off;
    
    mask = ones(3,3); it = 0;
    while max(max(I)) == 1
        I = imerode(I,mask);
        it = it + 1;
    end
    fprintf("Morphological thickness: %g\n", it);
end

function xx = diam(left, right, top, bottom)
    x = right-left;
    y = bottom-top;
    
    if (x > y)
        xx = x;
    else
        xx = y;
    end
end
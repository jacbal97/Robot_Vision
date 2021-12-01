% Clear Workspace
clc;
clear;
close all;

% Load Files
imgFiles = dir('..\images_2\*.bmp');

% Variables
circle = [init('..\images_2\circle_1.bmp');init('..\images_2\circle_2.bmp')];
cross = init('..\images_2\cross_1.bmp');
dumbbell = [init('..\images_2\dumbbell_1.bmp');init('..\images_2\dumbbell_2.bmp')];
ellipse = [init('..\images_2\ellipse_1.bmp');init('..\images_2\ellipse_2.bmp');init('..\images_2\ellipse_3.bmp')];
rectangle = [init('..\images_2\rectangle_1.bmp'); init('..\images_2\rectangle_2.bmp')];
square = [init('..\images_2\square_1.bmp');init('..\images_2\square_2.bmp');init('..\images_2\square_3.bmp')];
trapeze = [init('..\images_2\trapeze_1.bmp');init('..\images_2\trapeze_2.bmp')];

% Main Function
%printDir(imgFiles);
showPlane(circle, cross, dumbbell, ellipse, rectangle, square, trapeze);

% Functions
function x = initTable(imgFiles)
    % WIP
    path = '..\images_2\';
    for i=1:length(imgFiles)
        x(i) = {extractBefore(imgFiles(i).name, "_"); compactness(imread(path+imgFiles(i).name)); circularity(imread(path+imgFiles(i).name))};
    end
end

function showPlane(circle, cross, dumbbell, ellipse, rectangle, square, trapeze)
    figure;
    xlabel('compactness');
    ylabel('circularity');
    hold on;
    showPlanePlot(circle, 'o');
    %showPlanePlot(cross, '+');
    showPlanePlot(dumbbell, '*');
    showPlanePlot(ellipse, '.');
    showPlanePlot(rectangle, 'x');
    showPlanePlot(square, 's');
    showPlanePlot(trapeze, 'p');
    hold off;
end

function showPlanePlot(obj, symbol)
    for i=1:length(obj)
        plot(obj(i,1), obj(i,2), symbol);
    end
end

function x = init(path)
    I = imread(path);
    comp = compactness(I);
    circ = circularity(I);
    x = [comp , circ];
end

function printDir(x)
    for i=1:length(x)
        disp(x(i).name);
    end
end

function x = compactness(I)
    x = (getPerimeter(I)^2)/(4*pi*sum(sum(I)));
end

function x = circularity(I)
    center = box(I);
    bounds_tmp(:) = vertcat(bwboundaries(I));
    bounds = bounds_tmp{1};
    distance = 0;
    
    for i=1:length(bounds)
        distance(i) = getDistance(center, bounds(i,:));
    end
    
    sigma = mean(distance);
    micro = std(distance);
    
    x = sqrt(3)*sigma/micro;
end

function x = box(I)
    [rows, columns] = find(I);
    
    left = min(columns);
    right = max(columns);
    top = min(rows);
    bottom = max(rows);
    
    x = [(left-right)/2, (top-bottom)/2];
end

function [size, img] = getPerimeter(I)
    mask =[[1  1  1];[1 -8  1];[1  1  1]];
    img = imfilter(I, mask, 'conv');
    size = sum(sum(img));
end

function dist = getDistance(pos1, pos2)
    dist = sqrt(power((pos2(1)-pos1(1)),2) + power((pos2(2)-pos1(2)),2));
end
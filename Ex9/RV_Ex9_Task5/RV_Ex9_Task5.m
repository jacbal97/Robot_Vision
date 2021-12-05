% Clear Workspace
clc; clear; close all;

% Load Images
img_1 = imread('..\images\Bottles\bottles_1.jpg');
img_2 = imread('..\images\Bottles\bottles_7.jpg');
img_3 = imread('..\images\Bottles\bottles_8.jpg');

determine(img_1); determine(img_2); determine(img_3);
 
% Functions
function x = grayscale(I)
    x = (I(:,:,1)*0.587 + I(:,:,2)*0.499 + I(:,:,3)*0.224);
end

function x = binarization(I)
    I = imdilate(I > 150, strel('square', 3));
    I = imerode(I, strel('square', 12));
    I = imclose(I, strel('disk',10));
    I = imdilate(I, strel('disk', 10));
    x = imopen(I, strel('disk', 20));
    
end

function x = determine(k)
    I = k;
    I = binarization(grayscale(I));
    [~, height] = size(I);
    [obj, nobj] = bwlabel(~I);
    pos = [];
    
    if nobj == 0
        x = 0;
        return;
    end
    
    index = 1;
    while index < nobj
       [rows1, columns1] = find(obj == index);
       [rows2, columns2] = find(obj == (index+1));
       
       left_obj_1 = min(columns1); right_obj_1 = max(columns1);
       bottom_obj_1 = max(rows1); top_obj_1 = min(rows1);
       
       left_obj_2 = min(columns2); right_obj_2 = max(columns2);
       bottom_obj_2 = max(rows2); top_obj_2 = min(rows2);
       
       if bottom_obj_1 - top_obj_1 < 0.35*height
           index = index + 1;
       else
           if bottom_obj_2 < top_obj_1
              if left_obj_2 > left_obj_1 && right_obj_2 < right_obj_1
                  pos = [pos,[left_obj_1, top_obj_2, right_obj_1 - left_obj_1, bottom_obj_1 - top_obj_2]];
                  if index < nobj - 2
                      index = index + 2;
                  else
                      break;
                  end
              else
                 index = index + 1; 
              end
           else
               index = index + 1;
           end
       end
    end
    
    pos = reshape(pos, 4,[]);
    
    figure;
    imshow(k);
    for i=1:size(pos,2)
        rectangle('Position', pos(:,i), 'EdgeColor', 'g');
    end
end
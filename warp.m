function warped_img = warp(I1, new_points, H)
% INPUTS
%   I1          - Original Image
%   new_points  - final output points
%   H           - Homography matrix from subset of I1 points to new_points
% OUTPUTS
%   warped_img	- Final warped image
    xRange = max(new_points(:,1)) - min(new_points(:,1)) + 1;
    yRange = max(new_points(:,2)) - min(new_points(:,2)) + 1;
    warped_img = zeros(xRange, yRange, 3, 'uint8');
    for x = 1:xRange
        for y = 1:yRange
            currentPointsHom = [x; y; 1];
            originalPointsHom = H \ currentPointsHom;
            originalPoints = fix(originalPointsHom ./ originalPointsHom(3,1));
            warped_img(x, y, :) = I1(originalPoints(2,1), originalPoints(1,1), :);
        end
    end
end
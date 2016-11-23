function H = computeH(points, new_points)
% INPUTS
%   points      - points in the original image. 4x3 matrix.
%   new_points  - points in the new image. 4x3 matrix.
%
% OUTPUTS
%   H	- Homograph transformation from points to new_points
    [row col] = size(points);
    P = zeros(2 * row,9);
    for i = 1:row
        P(2 * i - 1,:) = [points(i,1), points(i,2), 1, 0, 0, 0, -points(i,1) * new_points(i,1), -points(i,2) * new_points(i,1), -new_points(i,1)];
        P(2 * i,:) = [0, 0, 0, points(i,1), points(i,2), 1, -points(i,1) * new_points(i,2), -points(i,2) * new_points(i,2), -new_points(i,2)];
    end
    [~,~,V] = svd(P);
    V = V';
    H = reshape(V(end,:),[3,3])';
end
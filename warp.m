function warped_img = warp(I1, new_points, H)
% INPUTS
%   I1          - Original Image
%   new_points  - final output points
%   H           - Homography matrix from subset of I1 points to new_points
% OUTPUTS
%   warped_img	- Final warped image
logoimgr = I1(:,:,1);
logoimgg = I1(:,:,2);
logoimgb = I1(:,:,3);
xRange = max(new_points(:,1)) - min(new_points(:,1));
yRange = max(new_points(:,2)) - min(new_points(:,2));
warped_img = zeros(xRange, yRange, 3);
[row, col] = size(new_points);
newPointsHom = [new_points'; ones(1,row)];
originalPoints = H \ newPointsHom;
originalPoints = round(originalPoints ./ originalPoints(end,:));
[height, width, ~] = size(I1);
[rX, rY] = meshgrid(1:width, 1:height);
concernedPoints = inpolygon(rX, rY, originalPoints(1,:), originalPoints(2,:));

sourcePoints = [rX(concernedPoints) rY(concernedPoints)]';
sz = size(sourcePoints);
XYZ = [sourcePoints(1,:); sourcePoints(2,:); ones(1,sz(:,2))];
XYZ = H*XYZ;
XYZ=XYZ./XYZ(end,:);
ZIr=interp2(double(logoimgr), XYZ(1,:)',XYZ(2,:)');
ZIg=interp2(double(logoimgg), XYZ(1,:)',XYZ(2,:)');
ZIb=interp2(double(logoimgb), XYZ(1,:)',XYZ(2,:)');

szXYZ=size(XYZ);
for i=1:szXYZ(1,2)
    warped_img(sourcePoints(1,i),sourcePoints(2,i),1)=ZIr(i,1);
    warped_img(sourcePoints(1,i),sourcePoints(2,i),2)=ZIg(i,1);
    warped_img(sourcePoints(1,i),sourcePoints(2,i),3)=ZIb(i,1);
end;

end
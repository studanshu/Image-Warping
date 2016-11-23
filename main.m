I1 = imread('stadium.jpg');
figure(10);
imshow(I1);
points = round(ginput(4));
figure(1);
subplot(1,2,1);
imshow(I1);
new_points = [[1, 1];
              [1, 500];
              [200, 500];
              [200, 1]]; % choose your own set of points to warp your ad too
H = computeH(points, new_points);
% warp will return just the ad rectified
warped_img = warp(I1, new_points, H);
subplot(1,2,2);
imshow(warped_img);
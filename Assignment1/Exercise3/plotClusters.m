function [  ] = plotClusters( clusters, gestureType, algorithmType )
%PLOTCLUSTERS Summary of this function goes here
%   Detailed explanation goes here
figure(1);
hold on;
plot3(clusters{1}(:,1),clusters{1}(:,2),clusters{1}(:,3),'.','color','blue');
plot3(clusters{2}(:,1),clusters{2}(:,2),clusters{2}(:,3),'.','color','black');
plot3(clusters{3}(:,1),clusters{3}(:,2),clusters{3}(:,3),'.','color','red');
plot3(clusters{4}(:,1),clusters{4}(:,2),clusters{4}(:,3),'.','color','green');
plot3(clusters{5}(:,1),clusters{5}(:,2),clusters{5}(:,3),'.','color','magenta');
plot3(clusters{6}(:,1),clusters{6}(:,2),clusters{6}(:,3),'.','color','yellow');
plot3(clusters{7}(:,1),clusters{7}(:,2),clusters{7}(:,3),'.','color','cyan');
title(['Gesture ',gestureType,' : ', algorithmType]);
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on
end


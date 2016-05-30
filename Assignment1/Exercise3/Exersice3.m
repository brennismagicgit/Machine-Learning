clear all;

%% Params

load('gesture_dataset.mat');


data = reshape(gesture_o,600,3);
init_cluster = init_cluster_o;

%% K means
n = length(init_cluster);
N = length(data);
epochs = 0;
distances = cell(1,n);  % dists of data points to each cluster center
euklSum = cell(1,n);
clusters = cell(1,n);
y = init_cluster;       % 7x3 matrix

newTotalDistortion = 100;
decrement = 1;
while(decrement > 10e-6)
    epochs = epochs+1;
    for k=1:n
        dists = zeros(1,N);
        for j=1:N
            dists(j) = norm(data(j,:)-y(k,:));
        end
        distances{k} = dists';
    end
    
    [v,cluster] = min(cell2mat(distances)');    % find cluster with min dist
    
    for k=1:n                                   % add to corresponding cluster
        I = find(cluster ==k);
        clusters{k} = data(I,:);
        y(k,:) = mean(clusters{k});
    end
    for k=1:n
       eukl=zeros(1,length(clusters{k}));
       for j=1:length(clusters{k})
           eukl(j) = norm(clusters{k}(j,:)-y(k,:));
       end
       euklSum{k} = sum(eukl); 
    end
    oldTotalDistortion = newTotalDistortion;
    newTotalDistortion = sum(cell2mat(euklSum));
    decrement = abs(oldTotalDistortion-newTotalDistortion);
    disp(epochs);
end

figure;
hold on;
plot3(clusters{1}(:,1),clusters{1}(:,2),clusters{1}(:,3),'.','color','red');
plot3(clusters{2}(:,1),clusters{2}(:,2),clusters{2}(:,3),'.','color','blue');
plot3(clusters{3}(:,1),clusters{3}(:,2),clusters{3}(:,3),'.','color','yellow');
plot3(clusters{4}(:,1),clusters{4}(:,2),clusters{4}(:,3),'.','color','cyan');
plot3(clusters{5}(:,1),clusters{5}(:,2),clusters{5}(:,3),'.','color','green');
plot3(clusters{6}(:,1),clusters{6}(:,2),clusters{6}(:,3),'.','color','black');
plot3(clusters{7}(:,1),clusters{7}(:,2),clusters{7}(:,3),'.','color','magenta');
%plot3(init_cluster(:,1),init_cluster(:,2),init_cluster(:,3),'x','lineWidth',2,'color','blue');
%plot3(y(:,1),y(:,2),y(:,3),'x','lineWidth',2,'color','black');






% n = length(init_clusters);
% [R,C] = size(data);
% distortion = 1;
% distortions = cell(1,n);        
% dissimilarities = cell(1,n);    % dissimilarities of all points to all clusters
% 
% cluster_center = init_clusters;
% clusters = cell(1,n);
% m = 0;













% figure(1);
% plot3(data(:,1),data(:,2),data(:,3),'.','MarkerSize',2);
% hold on;
% %while(distortion > 10e-6)
% for x=1:5 
%     for k = 1:n                          % for all clusters
%        tmp = zeros(length(data),1);
%        for i = 1:R                       % for all data points
%            tmp(i) =  norm(data(i,:)-cluster_center(k,:));
%        end
%        dissimilarities{k} = tmp;
%     end
%     [v,i] = min(cell2mat(dissimilarities)');
%     for k=1:n                          % add least dissimilarity to cluster k
%         I = find(k == i);
%         clusters{k} = data(I,:);
%         cluster_center(k,:) = sum(clusters{k})/length(clusters{k});
%         distortions{k} = mean2(bsxfun(@minus,clusters{k},cluster_center(k,:)).^2);     % calc total distortion
%     end
%     distortion = sum(cell2mat(distortions));
%     %plot3(cluster_center(:,1),cluster_center(:,2),cluster_center(:,3),'x');
%     disp(distortion);
% end
























clear all;

%% Params

load('gesture_dataset.mat');


data = reshape(gesture_l,600,3);
init_cluster = init_cluster_l;

% %% Binary Split
% 
% v = [0.08, 0.05, 0.02];
% K = 7;
% 
% center = mean(data);
% initDistorsion = sum(pdist2(data,center));
% 
% clusters = cell(1,7);
% distorsions = cell(1,7);
% centers = cell(1,7);
% 
% clusters{1} = data;
% distorsions{1} = initDistorsion;
% centers{1} = center;
% 
% for k=2:7%K
%     
%     [M,I] = max(cell2mat(distorsions));     % find cluster with max distorsion
%     
%     y_tmp = mean(clusters{I});
%     
%     aDists = pdist2(clusters{I},y_tmp+v);
%     bDists = pdist2(clusters{I},y_tmp-v);
%     
%     [M, x] = min([aDists';bDists']);        % find closest a/b cluster center
%     [M, Xa_i] = find(x==1);
%     [M, Xb_i] = find(x==2);
%     
%     clusters{k} = clusters{I}(Xb_i,:);      % Split Cluster
%     clusters{I} = clusters{I}(Xa_i,:);
%     
%     center_a = mean(clusters{I}); % Calculate new cluster Center
%     center_b = mean(clusters{k});
%     
%     distorsions{I} = sum(pdist2(clusters{I},center_a)); % Update Distorsions
%     distorsions{k} = sum(pdist2(clusters{k},center_b));
%     centers{I} = center_a;
%     centers{k} = center_b;
% end



%% K means
n = length(init_cluster);

distances = cell(1,n);  % dists of data points to each cluster center
euklSum = cell(1,n);
clusters = cell(1,n);
y = init_cluster;       % 7x3 matrix

newTotalDistortion = 100;
decrement = 1;

threshold = 10e-6;
epochs = 0;

while(decrement > threshold)
    epochs = epochs+1;
    for k=1:n
        distances{k} = pdist2(data,y(k,:));
    end   
    [v,cluster] = min(cell2mat(distances)');    % find cluster with min dist 
    for k=1:n                                   % add to corresponding cluster
        I = find(cluster ==k);
        clusters{k} = data(I,:);
        y(k,:) = mean(clusters{k});
    end
    for k=1:n                                  % get Total eukl Sum for each cluster
       euklSum{k} = sum(pdist2(clusters{k},y(k,:)));  
    end
    oldTotalDistortion = newTotalDistortion;
    newTotalDistortion = sum(cell2mat(euklSum));
    decrement = abs(oldTotalDistortion-newTotalDistortion);
end

% figure(1);
% hold on;
% plot3(clusters{1}(:,1),clusters{1}(:,2),clusters{1}(:,3),'.','color','blue');
% plot3(clusters{2}(:,1),clusters{2}(:,2),clusters{2}(:,3),'.','color','black');
% plot3(clusters{3}(:,1),clusters{3}(:,2),clusters{3}(:,3),'.','color','red');
% plot3(clusters{4}(:,1),clusters{4}(:,2),clusters{4}(:,3),'.','color','green');
% plot3(clusters{5}(:,1),clusters{5}(:,2),clusters{5}(:,3),'.','color','magenta');
% plot3(clusters{6}(:,1),clusters{6}(:,2),clusters{6}(:,3),'.','color','yellow');
% plot3(clusters{7}(:,1),clusters{7}(:,2),clusters{7}(:,3),'.','color','cyan');

























function [ clusters ] = kMeans( gesture_, init_cluster_ )
%KMEANS Summary of this function goes here
%   Detailed explanation goes here

data = reshape(gesture_,600,3);
init_cluster = init_cluster_;

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
    for k=1:n                                  % get Total eukl Sum for each cluster
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

end


function [] = kMeans( gesture_, init_cluster_ , nClusters )
%KMEANS
    data = reshape(gesture_,600,3);
    init_cluster = init_cluster_;

    n = nClusters;

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
    
    plotClusters(clusters,'K-Means');
end

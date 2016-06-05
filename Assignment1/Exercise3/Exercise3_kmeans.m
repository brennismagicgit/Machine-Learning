function [] = Exercise3_kmeans( gesture_l, gesture_o, gesture_x, init_cluster_l, init_cluster_o, init_cluster_x, nClusters )
    kMeans(gesture_l,init_cluster_l,nClusters);
    kMeans(gesture_o,init_cluster_o,nClusters);
    kMeans(gesture_x,init_cluster_x,nClusters);
end


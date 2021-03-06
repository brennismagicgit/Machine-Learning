function [ means,Covs,priors,Clusters] = initGMMparams( Data,k )
%This function initializes the Parameters for a GMM
    [ci,means]=kmeans(Data',k); % Cluster Means
    priors = ones(k,1)*1/k;     % uniform priors
    Covs   = cell(k,1);         
    Clusters = cell(k,1);
    for i=1:k
        idx = find(ci==i);
        Clusters{i,1} = Data(:,idx);    % Cluster Data Points
        Covs{i,1} = cov(Data(:,idx)');  % Cluster Covariances
    end
end


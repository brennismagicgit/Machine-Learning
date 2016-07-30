function [ means,Covs,priors,Clusters] = initGMMparams( Data,k )
%INITGMMPARAMS Summary of this function goes here
%   Detailed explanation goes here
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


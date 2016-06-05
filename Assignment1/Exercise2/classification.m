function [ matchRate,prediction] = classification( d,images,labels,t10k,l10k)
% This function performs a Bayes Classification and PCA preprocessing
% INPUT     (dValue,trainImages,trainLabels,testImages,testLabels)
% OUTPUT    (matchRate,Predicition)
%% PCA analysis

m1 = mean(images');
zeroMeanImages = bsxfun(@minus,images,m1');       % create zero mean image
s = cov(zeroMeanImages');
[v , u] = eig(s);
u = diag(u);
[u,i] = sort(u,'descend');

W = v(:,i(1:d));                            % calculate base
y = W'*zeroMeanImages;                      % Project base

%% Calculate Training Mean and Covariance
covClassesProj = cell(1,10);
meanClassesProj = cell(1,10);

for i=0:9
    % calculate mean and Covariance for each Projected Class
    label = find(labels == i);
    class = y(:,label);                    
    meanClassesProj{i+1} = mean(class');
    covClassesProj{i+1} = cov(class');
end

%% Associate Classes

likelihood = zeros(length(t10k),10);

for i=0:9
    % calculated likelihood for each class for zero mean test set
    projection = W'*(bsxfun(@minus,t10k,m1'));
    mu = meanClassesProj{i+1};             
    cova = covClassesProj{i+1};
    likelihood(:,i+1) = mvnpdf(projection',mu,cova);
end

% extract class with hightest likelihood
[winners,index] = max(likelihood,[],2);
prediction = index-1;
match = prediction==l10k;
matchRate = sum(match)/length(match);

end


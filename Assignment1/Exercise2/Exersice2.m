tic;
clear all
%% Parameters
% d = 15;
% 
% images = loadMNISTImages('train-images.idx3-ubyte');
% labels = loadMNISTLabels('train-labels.idx1-ubyte');
% t10k = loadMNISTImages('t10k-images.idx3-ubyte');
% l10k = loadMNISTLabels('t10k-labels.idx1-ubyte');
% 
% 
% %% PCA analysis
% 
% m1 = mean2(images);                 % calc mean of all images
% zeroMeanImages = images - m1;        % create zero mean image
% s = cov(zeroMeanImages');
% [v , u] = eig(s);
% u = diag(u);
% [u,i] = sort(u,'descend');
% 
% W = v(:,i(1:d));                    % calculate base
% y = W'*images;                      % Project base
% 
% 
% 
% %% Calculate Training Mean and Covariance
% 
% meanClasses = cell(1,10);
% covClasses = cell(1,10);
% 
% for i=0:9
%     label = find(labels == i);
%     class = images(:,label);
%     meanClasses{i+1} = mean2(class);
%     proj = W'*class;
%     covClasses{i+1} = cov(proj');
% end
% 
% %% Associate Classes
% 
% testData = {t10k-meanClasses{1}; t10k-meanClasses{2}; ...   % test data with zero mean of respective class
%             t10k-meanClasses{3}; t10k-meanClasses{4}; ...
%             t10k-meanClasses{5}; t10k-meanClasses{6}; ...
%             t10k-meanClasses{7}; t10k-meanClasses{8}; ...
%             t10k-meanClasses{9}; t10k-meanClasses{10}};
%         
% likelihood = zeros(length(t10k),10);
% 
% for i=0:9
%     projection = W'*testData{i+1};
%     mu = meanClasses{i+1};
%     cova = covClasses{i+1};
%     likelihood(:,i+1) = mvnpdf(projection',mu,cova);
% end
%   
% 
% [winners,i] = max(likelihood,[],2);
% prediction = i-1;
% missclassification = sum(prediciton)/length(predicion);

error = zeros(1,60);
d_x   = [1:1:60];

for d=1:60
    disp(d);
    error(d) = classification(d);
      
end

scatter(d_x,error);
xlabel('d')
ylabel('error')
title('Errors over d values')
gird on











toc;
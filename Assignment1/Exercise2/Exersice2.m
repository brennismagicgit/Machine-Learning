tic;
clear all
%% Parameters
d = 15;
 
images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');
t10k = loadMNISTImages('t10k-images.idx3-ubyte');
l10k = loadMNISTLabels('t10k-labels.idx1-ubyte');

m1 = mean2(images);                 % calc mean of all images
zeroMeanImages = images - m1;        % create zero mean image
s = cov(zeroMeanImages');
[v , u] = eig(s);
u = diag(u);
[u,i] = sort(u,'descend');

W = v(:,i(1:d));                    % calculate base
y = W'*images;                      % Project base


%% Calculate Training Mean and Covariance

meanClasses = cell(1,10);
covClasses = cell(1,10);
meanClassesProj = cell(1,10);

for i=0:9
    label = find(labels == i);
    class = images(:,label);
    proj = W'*class;
    meanClasses{i+1} = mean2(class); 
    meanClassesProj{i+1} = mean2(proj);
    covClasses{i+1} = cov(proj');
end

%% Associate Classes

testData = {t10k-meanClasses{1}; t10k-meanClasses{2}; ...   % test data with zero mean of respective class
            t10k-meanClasses{3}; t10k-meanClasses{4}; ...
            t10k-meanClasses{5}; t10k-meanClasses{6}; ...
            t10k-meanClasses{7}; t10k-meanClasses{8}; ...
            t10k-meanClasses{9}; t10k-meanClasses{10}};
        
likelihood = zeros(length(t10k),10);

for i=0:9
    projection = W'*testData{i+1};
    mu = meanClasses{i+1};   % TODO meanClasses{i+1};          
    cova = covClasses{i+1};
    likelihood(:,i+1) = mvnpdf(projection',mu,cova);
end
  
[winners,index] = max(likelihood,[],2);
prediction = index-1;
match = prediction==l10k;
matchRate = sum(match)/length(match);
missclassificationRate = 1-matchRate;

[C,order] = confusionmat(l10k,prediction);

% len = 60;
% 
% matchRate = zeros(1,len);
% missmatchRate = zeros(1,len);
% 
% d_x   = [1:1:len];
% 
% for d=1:len
%     disp(d);
%     [m,mis] = classification(d,images,labels,t10k,l10k);
%     matchRate(d) = m;
%     missmatchRate(d) = mis;
% end
% 
% figure;
% scatter(d_x,matchRate);
% xlabel('d')
% ylabel('Match Rate')
% title('Match Rate over values of d')
% grid on
% figure;
% scatter(d_x,missmatchRate);
% xlabel('d')
% ylabel('Missmatch Rate')
% title('Missmatch Rate over values of d')
% grid on









toc;
tic;
clear all
%% Parameters
d = 5;

images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');
t10k = loadMNISTImages('t10k-images.idx3-ubyte');
l10k = loadMNISTLabels('t10k-labels.idx1-ubyte');


%% PCA analysis

M1 = mean(images);                   % mean of rows
m1 = mean(M1);                        % mean of images
zeroMeanImages = images - m1;        % create zero mean image
s = cov(images');
[v , u] = eig(s);
u = diag(u);
[u,i] = sort(u,'descend');

W = v(:,i(1:d));                    % calculate base
y = W'*images;                      % Project base



%% Associate Classes

























%% Associate Classe

data = [l10k,t10k'];
classes = cell(1,10);
zeroMeanClasses = cell(1,10);
covClasses = cell(1,10);
means = cell(1,10);
projection = cell(1,10);
likelyhood = cell(1,10);

for i = 0:9
    classIndex = find(data(:,1)==i);       % find class index
    class = data(classIndex,2:end);
    m2 = mean2(class);                      % clac class mean
    means{i+1} = m2;                        
    classes{i+1} = class';                  
    zeroMeanClasses{i+1} = class'- m2;      % calc zero Mean class
    covClasses{i+1} = cov(class);           % calc cov Matrix
    projection{i+1} = W'*class';
    %likelyhood = (1/(((2*pi)^(d/2))*norm(covClasses{i+1}))...
    %             *
end













toc;
function [ par ] = Exercise1( k )
%EXERCISE1 Summary of this function goes here
%   Detailed explanation goes here

load('Data.mat');

% preparing training data X
training_data = [Input(1,:)',Input(2,:)',(Input(1,:).*Input(2,:))'];
training_data = [ones(length(Input),1),training_data,training_data.^2,  ...
                training_data.^3,training_data.^4,training_data.^5,     ...
                training_data.^6];
% prepare k-fold cross validation data for each fold
foldSize = floor(length(Input)/k);
nFolds = foldSize*ones(1,k);
% if test data size not divisibel through k without rest
rest = mod(length(Input),foldSize);
iFold = mat2cell(training_data,[nFolds,rest],[19]);
oFold = mat2cell(Output',[nFolds,rest],[3]);

positionErrors = {};
orientationErrors = {};

weights = {};

for p=1:6
    for j=1:k-1
        fold = iFold{j};
        % Training
        X = fold(:,1:1+p*3);  % succesive raising of p degree
        y = oFold{j};
        w = (X.'*X)\X.'*y;
        weights{p,j} = w;
        % Testing
        testY = [iFold{k}(:,1:1+p*3)] * w;
        Errors = ((testY-oFold{k}).^2).^(0.5);
        positionErrors{p,j} = sum(Errors(:,1)+Errors(:,2))/length(Errors);
        orientationErrors{p,j} = sum(Errors(:,3))/length(Errors);
    end
end
positionErrors = cell2mat(positionErrors);

[m,poldeg] = min(mean(positionErrors')'); 
[M,fold  ] = min(positionErrors(poldeg,:));
index = [poldeg, fold];  % row col of min Error in positionError cell

par{1} = weights{index(1),index(2)}(:,1);
par{2} = weights{index(1),index(2)}(:,2);
par{3} = weights{index(1),index(2)}(:,3);

end


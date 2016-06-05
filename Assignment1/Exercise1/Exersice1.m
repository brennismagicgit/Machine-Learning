function [ par ] = Exersice1( K )
%EXERSICE1

% This matlab Funtion produces the par cell with Trained Parameters for
% different values of K
 
    load('Data.mat');

    training_data = [Input(1,:)',Input(2,:)',(Input(1,:).*Input(2,:))'];
    training_data = [ones(length(Input),1),training_data,training_data.^2,  ...
                    training_data.^3,training_data.^4,training_data.^5,     ...
                    training_data.^6];

    %% K Cross Validation Linear Regression

    % prepare k-fold cross validation data for each fold
    foldSize = floor(length(Input)/K);
    nFolds = foldSize*ones(1,K);
    % if test data size not divisibel through k without rest
    rest = mod(length(Input),foldSize);
    iFold = mat2cell(training_data,[nFolds,rest],[19]);
    oFold = mat2cell(Output',[nFolds,rest],[3]);

    positionErrors =    zeros(6,1);
    orientationErrors = zeros(6,1);

    % Training
    for k=1:K   
        trainIndex = [1:k-1,k+1:K];
        validationX =   iFold(k);                   % Validation Set
        validationY =   oFold(k);
        trainI =    cell2mat(iFold(trainIndex));    % Training Set
        trainO =    cell2mat(oFold(trainIndex));
        for p=1:6
            X = trainI(:,1:1+p*3);
            y = trainO;
            w = (X.'*X)\X.'*y;

            Xw = validationX{1};
            yw = Xw(:,1:1+p*3)*w;                     

            yk = validationY{1};

            Errors = (yk-yw);           % Validation

            positionErrors(p) =  mean(sqrt(Errors(:,1).^2+Errors(:,2).^2)) + positionErrors(p);
            orientationErrors(p) = mean(abs(Errors(:,3))) + orientationErrors(p);
        end
    end

    par = cell(1,3);
    % Finding optimal pol deg for position and orientation Estimation
    [minError_p, p1] = min(positionErrors);
    [minError_o, p2] = min(orientationErrors);
    % Calculate weights for optimal pol deg with all training data
    XPos = training_data(:,1:1+3*p1);
    yPos = Output';

    wPos = (XPos.'*XPos)\XPos.'*yPos;

    par{1} = wPos(:,1);
    par{2} = wPos(:,2);

    XOri = training_data(:,1:1+3*p2);
    yOri = Output';

    wOri = (XOri.'*XOri)\XOri.'*yOri;

    par{3} = wOri(:,3);


end


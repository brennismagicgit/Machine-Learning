function [ d_opt,minError,C ] = Exercise2( d_max )
%EXERSICE2
    tic;
    %% Input
    len = d_max;
    
    %% Parameters
    images = loadMNISTImages('train-images.idx3-ubyte');
    labels = loadMNISTLabels('train-labels.idx1-ubyte');
    t10k = loadMNISTImages('t10k-images.idx3-ubyte');
    l10k = loadMNISTLabels('t10k-labels.idx1-ubyte');

    d_x   = (1:1:len);
    matchRate = zeros(1,len);
    missmatchRate = zeros(1,len);
    predicitions = cell(1,len);

    %% Perform Performance Checking of d vlaues From 1 to 60

    for d=1:len
        disp([mat2str(round((100/len)*d)),' %']);
        [m,prediction] = classification(d,images,labels,t10k,l10k);
        matchRate(d) = m;
        missmatchRate(d) = 1-m;
        predicitions{d} = prediction;
    end

    [v,i] = max(matchRate);
    classificationResult = predicitions{i};
    
    % Results
    d_opt = i;
    minError = 1-v;
    C = confusionmat(l10k,classificationResult);


    %% Display Results

    disp(['Best value of d: ', mat2str(i)]);
    disp(['Match rate: ', mat2str(v*100), '%']);
    disp(['Error for d = 15: ',mat2str(missmatchRate(15)*100), '%']);

    % --> uncomment this part to plot confusion matrix 
    %figure;
    %plotconfusion(l10k,classificationResult);

    figure;
    scatter(d_x,matchRate);
    xlabel('d')
    ylabel('Match Rate')
    title('Match Rate over values of d')
    grid on
    axis([0 60 0 1]);
    figure;
    scatter(d_x,missmatchRate);
    xlabel('d')
    ylabel('Missmatch Rate')
    title('Missmatch Rate over values of d')
    grid on
    axis([0 60 0 1]);

    toc;

end


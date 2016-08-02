load('dataGMM.mat');
    
% Programm parameters
K = 4;
N = length(Data);
epsilon = 1e-9;
pre_likelihood = 0;
likelihood = 0;
delta = 1;
% initialize parameter
[means,covs,priors,clusters] = initGMMparams( Data, K);
% DISPALY MEANS AND COVS
% initialize pdfs
pdfs = cell(1,K);
for k=1:K
    pdfs{k} = mvnpdf(Data',means(k,:),covs{k});
end
% start EM algorithm
it = 0;
while delta > epsilon
    
    it = it+1;
    
    responsibilities = cell(1,K);
    normalisation = 0;
    % E Step - Evaluate Responibilities
    tmp_pdfs = cell2mat(pdfs);
    for k=1:K
        tmp_response = zeros(N,1);
        for i=1:N
            tmp_response(i) = priors(k)*tmp_pdfs(i,k)/(tmp_pdfs(i,:)*priors);   
        end
        responsibilities{k}=tmp_response;
    end
    % M Step - Re-estimate parameters using current responsibilities
    for k=1:K
        nk = sum(responsibilities{k});
        means(k,:) = (1/nk)*responsibilities{k}'*Data'; % means
        priors(k) = nk/N;                               % priors
        
        tmp_cov = zeros(2,2);
        tmp_responsibilities = responsibilities{k};
        for i=1:N
            tmp_cov = tmp_cov+tmp_responsibilities(i)*(Data(:,i)-means(k,:)')*(Data(:,i)-means(k,:)')';
        end
        covs{k} = (1/nk)*tmp_cov;                       % covariance
    end
    % Evaluate log likelihood of parameters - Recalculate pdfs with updated parameters
    for k=1:K
        pdfs{k} = mvnpdf(Data',means(k,:),covs{k});
    end
    pre_likelihood = likelihood;
    likelihood = sum(log(cell2mat(pdfs)*priors));
    % check for convergence
    delta = abs(pre_likelihood-likelihood);    
end
% Display Results
fprintf('Finished after %d Iterations\n',it);
fprintf('Means:\n');
disp(means);
fprintf('Priors:\n');
disp(priors);
fprintf('Covariances:\n');
for k=1:K
    fprintf('Cluster %d:\n',k);
    disp(covs{k});
    
end


 
   
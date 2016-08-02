clear;
% Load Data
A=importdata('A.txt'); 
B=importdata('B.txt');
pi=importdata('pi.txt');
A_test=importdata('A_Test_Binned.txt'); 
A_train=importdata('A_Train_Binned.txt'); 
% Parameters
N = 12;
M = 8;
L = length(A_train);
reps = size(A_train,2);

pSequence = zeros(N,L);
likelihood = zeros(1,reps);

for i=1:reps
    % init HMM parameters for sequence
    o = A_test(:,i);
    a = (B(o(1),:).* pi)';
    pSequence(:,1) = a;
    % for the rest of sequence
    for j=2:L
        tmp = zeros(N,1);
        for k=1:N
            t = pSequence(:,j-1)'*A(:,k);
            tmp(k) = t*B(o(j),k);
        end
        pSequence(:,j) = tmp;
    end
    prob = sum(pSequence(:,end));
    likelihood(i) = log(prob);
end
% classify log likelihood of repetition
C = zeros(1,reps);
% Test = 1 Train = 2
for i=1:reps
    if likelihood(i) <= -120
        C(i) = 1;
    else
        C(i) = 2;
    end
end
Result = [C;likelihood];





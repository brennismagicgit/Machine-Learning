function [ pattern ] = WalkQLearning( s )
%WALKQLEARNING
    % Params
    N = 16;         % number of states
    start = s;      % start State
    discount = 0.99;
    alpha = 0.25;
    epsilon = 0.5;
    IT = 1e5;       % number of iterations
    
    % Init Q and Policy
    Q = zeros(16,4);
    policy = zeros(16,1);
    
    for it = 1:IT
        p = rand();     % uniform random number between 0 and 1
        if p > epsilon  % pick greedy action
            q = Q(s,:);
            a = min(find(q == max(q))); % min --> if more elements are zero of row s
        else            % pick random action
            a = randi([1,4],1,1); % generate random integer from 1 to 4
        end
        
        [s_,r]  = SimulateRobot(s,a);
        Q(s,a) = Q(s,a) + alpha *( r + discount*max(Q(s_,:))-Q(s,a));
        s = s_;
    end
    
    % Extract policy
    for i=1:N
        q = Q(i,:);
        a = min(find(q==max(q)));
        policy(i) = a;
    end
    % Extract Pattern when starting from start state
    s = start;
    pattern = s;
    for i=1:N-1
        [s_,~] = SimulateRobot(s,policy(s));
        pattern = [pattern s_];
        s = s_;
    end
end


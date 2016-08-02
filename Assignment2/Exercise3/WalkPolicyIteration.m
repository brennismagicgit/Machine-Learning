function [ pattern ] = WalkPolicyIteration(s)
%POLICYITERATION

    % Parameters
    N = 16;         % number of states
    Act = 4;        % number of actions
    discount = 0.99;% discount factor
    it = 0;         % number of iterations
    V_pre = 1e10;
    done = 0;
    delta = 1e-8;

    % random policy initialisation
    policy = ceil(rand(16,1)*4);
    % Reward vector
    R = zeros(N,1);
    
    while done < 1
    
        it = it+1;
        A = eye(N);
    
        for i=1:N
            [s_,r] = SimulateRobot(i,policy(i));   % reward and nextstate of state i
            R(i) = r;
            A(i,s_) = A(i,s_) - discount;
        end
        % solve system vor new values of V after executing policy
        V = A\R;
        % find optimal policy and update
        for i=1:N
            argmax = 0;
            for j=1:Act
                [s_tmp,r_tmp] = SimulateRobot(i,j);
                val = r_tmp+discount*V(s_tmp);
                if val > argmax
                    policy(i) = j;
                    argmax = val;
                end
            end
        end
        % check for convergence
        if delta < abs(norm(V)-norm(V_pre))
            V_pre = V;
        else
            done = 1;
        end
    end
    fprintf('Finished after %d Iterations',it);
    
    % Extract pattern
    pattern = s;
    for i = 1:N-1
        [s_,~] = SimulateRobot(s,policy(s));
        pattern = [pattern s_];
        s = s_;
    end    
end


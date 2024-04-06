function [Ssave,Isave,Rsave] = ASIR(dt, mu_1, sig_1, mu_2, sig_2)

    b = 1/7;
    a = 2.3 * b; % average rate
    N = 1000;
    I = 5;
    R = 0;
    S = N - I - R;
    
    % Clock
    tmax = 200; 
    clockmax = tmax / dt;
    
    
    
    % Gaussian Mixture
    normal_1 = makedist('Normal','mu',mu_1,'sigma',sig_1);
    trunc_1 = truncate(normal_1, 0, 1);
    mean_1 = mean(trunc_1);
    
    
    normal_2 = makedist('Normal','mu',mu_2,'sigma',sig_2);
    trunc_2 = truncate(normal_2, 0, 1);
    mean_2 = mean(trunc_2);
    
    w = (a - mean_2) / (mean_1 - mean_2);
    
    
    
    % Assign Rates
    rng('shuffle'); %random seed
    rate = zeros(1, N); % vector of individual rates
    
    % Generate samples from the mixture distribution
    for i = 1 : N
        if rand < w
            rate(i) = random(trunc_1);
        else
            rate(i) = random(trunc_2);
        end
    end
    
    
    % WLOG first 5 nodes are infected
    status = zeros(1, N); 
    status(1: 5) = 1; 
    
    
    tsave = zeros(1, clockmax);
    Ssave = zeros(1, clockmax);
    Isave = zeros(1, clockmax);
    Rsave = zeros(1, clockmax);
    
    
    % Algorithm
    
    for clock = 1: clockmax
        t = clock * dt;
        risk = zeros(1, N); 
        free = zeros(1, N); 
        for i = 1 : N %initialize array
            free(i) = i;
        end
        for i = 1 : 2: N 
            j = i + unidrnd(N-i); % pointer to available index
            k = free(j); % available index
            % Pair node i with node k
            if (status(i) == 1) && (status(k) == 0)
                risk(i) = k;
            end
            if (status(i) == 0) && (status(k) == 1)
                risk(k) = i;
            end
         
            % Swap
            q = free(i+1); % save index 
            free(i+1) = k;
            free(j) = q;
        end 
    
        % Update States
        for i = 1: N
            if (status(i) == 1) % Node Infected
                if (risk(i) ~= 0)
                    j = risk(i);
                    a = (rate(i) + rate(j)) / 2; % average rates
                    p = a * dt;
                    if rand < p
                        status(j) = 3;
                        I = I + 1; %increment infected count
                        S = S - 1; %decrement susceptible
                    end
                end
                p = b * dt;
                if rand < p
                    status(i) = 2;
                    R = R + 1; %increment recovered
                    I = I - 1; %decrement infected
                end
            end
        end  
    
        % Newly Infected 
        for i = 1: N
            if (status(i) == 3)
                status(i) = 1;
            end
        end
    
        % Track Total
        tsave(clock) = t;
        Ssave(clock) = S;
        Isave(clock) = I;
        Rsave(clock) = R;
    
    end

end

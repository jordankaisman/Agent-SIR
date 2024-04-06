function [Ssave,Isave,Rsave] = DSIR(dt)

    b = 1/7;
    a = 2.3 * b; % average rate
    N = 1000;
    I = 5;
    R = 0;
    S = N - I - R;
    
    % Clock
    tmax = 200; 
    clockmax = tmax / dt;
    
    tsave = zeros(1, clockmax);
    Ssave = zeros(1, clockmax);
    Isave = zeros(1, clockmax);
    Rsave = zeros(1, clockmax);

    for clock = 1: clockmax
        t = clock * dt;
        newI = dt * a * (I / N) * S;
        newR = dt * b * I;
        S = S - newI;
        I = I + newI - newR;
        R = R + newR;
        tsave(clock) = t;
        Ssave(clock) = S;
        Isave(clock) = I;
        Rsave(clock) = R;
    end

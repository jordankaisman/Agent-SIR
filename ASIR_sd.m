function [B,C] = ASIR_sd(num_samples,mu_1, sig_1, mu_2, sig_2) %returns mean and std
    A = zeros(num_samples,4800, 'single'); 
    C = (1: 4800); 
    
    dt = 1/24;
    
    for i = 1: num_samples
        [~, myIdata, ~] = ASIR(dt,mu_1, sig_1, mu_2, sig_2);
        A(i,:) = myIdata;
    end
    
    B = sum(A,1) / num_samples; 
    
    
    for i = 1: num_samples
        C = C + (B - A(1,:)).^2;
    end

    C = C / num_samples; 
    C = sqrt(C);

end


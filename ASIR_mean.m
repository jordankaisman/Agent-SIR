function [B] = ASIR_mean(num_samples,mu_1, sig_1, mu_2, sig_2)

    A = zeros(num_samples,4800, 'single');    
    dt = 1/24;

    for i = 1: num_samples
        [~, Idata, ~] = ASIR(dt,mu_1, sig_1, mu_2, sig_2);
        A(i,:) = Idata;
    end
    
    B = sum(A,1) / num_samples; % mean
end


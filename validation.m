num_samples = 25; % 25 sample runs
for i = 1: 4
    
    mu_1 = 
    sig_1 = 
    mu_2 = 
    sig_2 = 

    dt = 2^i / 24; % time step
    clockmax = 4800 / 2^i;


    xaxis = (1: 2^i : 2^i * clockmax);
    B = ASIR_mean(num_samples,mu_1, sig_1, mu_2, sig_2);
    plot(xaxis, B)
    hold on
end

legend('1','2','4','8')
title("Average Infection Curves")
xlabel("Time")
ylabel("Number Infected")





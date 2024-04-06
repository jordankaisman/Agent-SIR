num_samples = 15;
% A1 = ASIR_mean(num_samples, 0.32, .01, 0.33, .01);
% 
% A2 = ASIR_mean(num_samples, 0.32, .04, 0.33, .04);
% 
% A3 = ASIR_mean(num_samples, 0.32, .08, 0.33, .08);
% 
% A4 = ASIR_mean(num_samples, 0.32, .2, 0.33, .2);

tdata = (1: 4800);

%[~, DIdata, ~] = DSIR(dt);


% plot(tdata, A1, tdata, A2, tdata, A3, tdata, A4, tdata, DIdata)
% title("ASIR Means for 15 Samples")
% legend('A1','A2','A3','A4','D') 


[A1, C1] = ASIR_sd(num_samples, 0.32, .01, 0.33, .01);

[A2, C2] = ASIR_sd(num_samples, 0.32, .04, 0.33, .04);

[A3, C3] = ASIR_sd(num_samples, 0.32, .08, 0.33, .08);

[A4, C4] = ASIR_sd(num_samples, 0.32, .2, 0.33, .2);

tiledlayout(2,2)

nexttile 
errorbar(tdata, A1, C1);
hold on
plot(tdata, A1, "black", "LineWidth", 3);
title("Error Bar for A1")

nexttile 
errorbar(tdata, A2, C2);
hold on
plot(tdata, A2, "black", "LineWidth", 3);
title("Error Bar for A2")

nexttile 
errorbar(tdata, A3, C3);
hold on
plot(tdata, A3, "black", "LineWidth", 3);
title("Error Bar for A3")

nexttile 
errorbar(tdata, A4, C4);
hold on
plot(tdata, A4, "black", "LineWidth", 3);
title("Error Bar for A4")

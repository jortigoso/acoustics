clear all
close all
clc 

[h, fs] = audioread('M5.wav');

nrev = (1:size(h))/fs;

env = abs(hilbert(h));
env_f = movmean(env, 5001);
env_dB = 20*log10(env_f./(20e-6));

figure(2)
subplot(2,1,1)
    plot(nrev, h);
    title("Preassure")
    xlabel("Time (s)")
    ylabel("Preassure")
    xlim([0 1]);
subplot(2,1,2)
    plot(nrev, env_dB);
    title("SPL (dB)");
    ylabel("SPL (dB)");
    xlabel("Time (s)");
    xlim([0 1]);
    
t20 = t_n(env_f, nrev, 20, 0);
t30 = t_n(env_f, nrev, 30, 0);

fprintf("T20: "+t20+"\n");
fprintf("T30: "+t30+"\n");

function t_n = t_n(h, t, dB, margin)

E = zeros(1, length(h));
for i=length(E):-1:2
    E(i) = E(i-1) + h(i)^2;
end
% Referenced to 20uPa, not needed.
E = 10*log10(E/(20e-6)^2);

max_e = max(E);
max_ind = find(E == max_e);

i = max_ind + 1;
while(max_e - E(i) < margin)
    i = i + 1;
end
t_init = t(i);

j = i + 1;
while(E(i) - E(j) < dB)
    j = j + 1;
end
t_end = t(j);

t_n = (t_end - t_init)*(60/dB);

% Slope adjustment
a = [t_init t_end];
b = [E(i) E(j)];

figure
plot(t, E);
hold on 
plot(a,b,'r','linewidth',3);
hold off
title("Adjustment for T"+dB);
ylabel("E (dB)");
xlabel("Time (s)");
xlim([0 1]);
ylim([-30 30])

end




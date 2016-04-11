clear;
clear All;
N = 20; %% number of points
t = [0:N-1]'/N; %% define time
%f = sin(2*pi*t).^5; %%define function

figure;hold;
% for t1=0.2:-0.005:0.1
%     f=heaviside(t-0.1)-heaviside(t-t1);
%     p = abs(fft(f)); % absolute value of the fft
%     p = p(1:N/2) % take the positve frequency half, only
%     plot((p),'*');
%     pause(0.5);
% end

f = exp(sin(2*pi*t)); %%define function
p = abs(fft(f))/(N/2); %% absolute value of the fft
p = p(1:N/2).^2 %% take the positve frequency half, only
plot(log10(p),'*');

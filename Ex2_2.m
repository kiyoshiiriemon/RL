clear all;
num_trials = 20;
num_plays = 2000;
rew_0 = zeros(num_trials, num_plays);
rew_01 = rew_0;
rew_001 = rew_0;
rew_s = rew_0;
rew_opt = rew_0;
bandits_ex = randn(10, 1);

b0 = Bandit2_2(bandits_ex, 0, false);
b01 = Bandit2_2(bandits_ex, 0.1, false);
b001 = Bandit2_2(bandits_ex, 0.01, false);
bs = Bandit2_2(bandits_ex, 0.01, true);

for i=1:num_trials
    %[r, ro] = Func2_2(num_plays, 0);
    [r, ro] = b0.play(num_plays);
    rew_0(i,:) = r;
    %[r, ro] = Func2_2(num_plays, 0.1);
    [r, ro] = b01.play(num_plays);
    rew_01(i,:) = r;
    %[r, ro] = Func2_2(num_plays, 0.01);
    [r, ro] = b001.play(num_plays);
    rew_001(i,:) = r;
    [r, ro] = bs.play(num_plays);
    rew_s(i,:) = r;
    rew_opt(i,:) = ro;
end

rew_0_plot = zeros(num_plays, 1);
rew_01_plot = zeros(num_plays, 1);
rew_001_plot = zeros(num_plays, 1);
rew_s_plot = zeros(num_plays, 1);
opt_plot = zeros(num_plays, 1);
for i=1:num_plays
    rew_0_plot(i) = mean(mean(rew_0(:,1:i)));
    rew_01_plot(i) = mean(mean(rew_01(:,1:i)));
    rew_001_plot(i) = mean(mean(rew_001(:,1:i)));
    rew_s_plot(i) = mean(mean(rew_s(:,1:i)));
    opt_plot(i) = mean(mean(rew_opt(:,1:i)));
end

clf;
plot_data = horzcat(rew_0_plot, rew_01_plot, rew_001_plot, rew_s_plot, opt_plot);
plot(plot_data);


num_trials = 100;
num_plays = 2000;
rew_0 = zeros(num_trials, num_plays);
rew_01 = rew_0;
rew_001 = rew_0;
rew_opt = rew_0;

for i=1:num_trials
    [r, ro] = Func2_2(num_plays, 0);
    rew_0(i,:) = r;
    [r, ro] = Func2_2(num_plays, 0.1);
    rew_01(i,:) = r;
    [r, ro] = Func2_2(num_plays, 0.01);
    rew_001(i,:) = r;
    rew_opt(i,:) = ro;
end

rew_0_plot = zeros(num_plays, 1);
rew_01_plot = zeros(num_plays, 1);
rew_001_plot = zeros(num_plays, 1);
opt_plot = zeros(num_plays, 1);
for i=1:num_plays
    rew_0_plot(i) = mean(mean(rew_0(:,1:i)));
    rew_01_plot(i) = mean(mean(rew_01(:,1:i)));
    rew_001_plot(i) = mean(mean(rew_001(:,1:i)));
    opt_plot(i) = mean(mean(rew_opt(:,1:i)));
end

clf;
plot_data = horzcat(rew_0_plot, rew_01_plot, rew_001_plot, opt_plot);
plot(plot_data);


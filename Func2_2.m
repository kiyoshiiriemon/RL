function [rew, rew_opt] = Func2_2( numplays, eps )
% numplays: the number of bandit plays
% eps: epsilon for random selection

numarms = 10;   % the number of arms

bandits_ex = randn(numarms, 1);
bandits_samples = cell(numarms, 1);
rew_opt = zeros(numplays, 1);
rew = zeros(numplays, 1);

% optimal selection
[maxv, optind] = max(bandits_ex);

for n=1:numplays
    % greedy selection
    selind = randi(numarms, 1);
    max_rew = -10000;
    for i=1:numarms
        v = bandit_reward(bandits_samples{i});
        %fprintf(1, '%d: %f\n', i, v);
        if v > max_rew
            max_rew = v;
            selind = i;
        end
    end
    %fprintf(1, 'select %d\n', selind);
    % random selection
    if eps > rand(1,1)
        selind = randi(numarms, 1);
    end
    
    %fprintf(1, 'selected %d\n', selind);
    
    % try and get reward
    vals = randn(numarms,1)*0.1 + bandits_ex;
    rew(n) = vals(selind);
    
    % optimal selection
    rew_opt(n) = vals(optind);
    
    bandits_samples{selind} = horzcat(bandits_samples{selind}, vals(selind));
    % update model
    % bandits_ex = bandits_ex + randn(numarms,1)*0.01;
end

end

function [rew] = bandit_reward(samples)
    if size(samples) == 0
        rew = 0;
    else
        rew = mean(samples);
    end
end

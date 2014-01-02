function [rew, rew_opt] = Func2_2( )
ntries = 1000;
eps = 0.01;     % epsilon for random selection
numarms = 10;   % the number of arms

bandits_ex = ones(numarms, 1);
bandits_samples = cell(numarms, 1);
rew_opt = 0;
rew = 0;

for n=1:ntries
    % greedy selection
    selind = randi(numarms, 1);
    for i=1:numarms
        v = mean(bandits_samples{i});
        if v > mean(bandits_samples{selind})
            selind = ind;
        end
    end
    
    % random selection
    if eps > rand(1,1)
        selind = randi(numarms, 1);
    end
    
    %fprintf(1, 'selected %d\n', selind);
    
    % try and get reward
    vals = randn(numarms,1)*0.1 + bandits_ex;
    rew = rew + vals(selind);
    
    % optimal selection
    [maxv, optind] = max(bandits_ex);
    rew_opt = rew_opt + vals(optind);
    
    % update model
    bandits_ex = bandits_ex + randn(numarms,1)*0.01;
end


end
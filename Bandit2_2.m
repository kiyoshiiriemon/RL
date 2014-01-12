classdef Bandit2_2
    % multi-arm bandit for ex2-2
    % 
    
    properties
        numarms
        epsilon
        use_softmax
        bandits_ex
        bandits_samples
        temperature
    end
    
    methods
        function obj = Bandit2_2(bandits_ex, epsilon, use_softmax)
            if nargin < 1
                bandits_ex = randn(obj.numarms, 1);
            end
            if nargin < 2
                epsilon = 0;
            end
            if nargin < 3
                use_softmax = false;
            end
            obj.numarms = size(bandits_ex,1);
            obj.bandits_ex = bandits_ex;
            obj.bandits_samples = cell(obj.numarms, 1);
            obj.epsilon = epsilon;
            obj.use_softmax = use_softmax;
            obj.temperature = 0.1;
        end
        function [selind] = select_softmax(obj, eps)
            v = zeros(obj.numarms, 1);
            for i=1:obj.numarms
                v(i) = exp(bandit_reward(obj.bandits_samples{i})/obj.temperature);
            end
            s = sum(v);
            selv = s * rand();
            selind = obj.numarms;
            a = 0;
            for i=1:obj.numarms-1
                a = a + v(i);
                if selv < a
                    selind = i;
                    break
                end
            end
        end
        function [selind] = select_eps_greedy(obj, eps)
            selind = randi(obj.numarms, 1);
            max_rew = -10000;
            for i=1:obj.numarms
                v = bandit_reward(obj.bandits_samples{i});
                %fprintf(1, '%d: %f\n', i, v);
                if v > max_rew
                    max_rew = v;
                    selind = i;
                end
            end
            %fprintf(1, 'select %d\n', selind);
            % random selection
            v = rand(1,1);
            if eps > v
                selind = randi(obj.numarms, 1);
                %fprintf(1, 'eps=%f, select %d\n', v, selind);
            end
        end
        function [rew, rew_opt] = play(obj, numplays)
            [~, optind] = max(obj.bandits_ex);
            rew_opt = zeros(numplays, 1);
            rew = zeros(numplays, 1);
            for n=1:numplays
                if obj.use_softmax
                    selind = obj.select_softmax();
                else
                    % greedy selection
                    selind = obj.select_eps_greedy(obj.epsilon);
                end
                
                %fprintf(1, 'selected %d\n', selind);
                
                % try and get reward
                vals = randn(obj.numarms,1)*0 + obj.bandits_ex;
                rew(n) = vals(selind);
                
                % optimal selection
                rew_opt(n) = vals(optind);
                
                obj.bandits_samples{selind} = horzcat(obj.bandits_samples{selind}, vals(selind));
                % update model
                % bandits_ex = bandits_ex + randn(numarms,1)*0.01;
            end
        end
    end
    
end

function [rew] = bandit_reward(samples)
    if size(samples) == 0
        rew = 0;
    else
        rew = mean(samples);
    end
end


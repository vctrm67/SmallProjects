function [instructions] = Hungarian(initial_formation, target_formation, beats)
% Assigns target locations to marchers using the Hungarian algorithm;

index = 1;
target_formation2 = target_formation;
for i = 1:size(target_formation2, 1)
    for j = 1:size(target_formation2, 2)
        if target_formation2(i, j) ~= 0
            target_formation2(i, j) = index;
            index = index + 1;
        end
    end
end

numberOfMarchers = max(initial_formation(:));
pathLength = [];

for i = 1:numberOfMarchers
    for j = 1:size(initial_formation, 1)
        for k = 1:size(initial_formation, 2)
            if initial_formation(j, k) == i
                path2 = [];
                for n = 1:size(target_formation, 1)
                    for o = 1:size(target_formation, 2)
                        Beats = 2 * (abs(n - j) + abs(o - k));
                        if target_formation(n, o) ~= 0 && Beats <= beats
                            path = sqrt((n - j)^2 + (o - k)^2);
                            path2 = [path2 path];
                        elseif target_formation(n, o) ~= 0 && Beats > beats
                            path = 10000;
                            path2 = [path2 path];
                        end
                    end
                end
                pathLength = [pathLength; path2];
            end
        end
    end
end

[C,COST,v,u,rMat] = lapjv(pathLength);


for i = 1:length(C)
    for j = 1:size(initial_formation, 1)
        for k = 1:size(initial_formation, 2)
            if initial_formation(j, k) == i
                for m = 1:size(target_formation2, 1)
                    for n = 1:size(target_formation2, 2)
                        if target_formation2(m, n) == C(i)
                            instructions(i).i_target = m;
                            instructions(i).j_target = n;
                            instructions(i).wait = 0;
                            instructions(i).direction = findDirection(j, k, m, n);
                        end
                    end
                end
            end
        end
    end
end
end
                                

function [direction] = findDirection(initial_i, initial_j, final_i, final_j)
%finds the direction
if initial_i == final_i || initial_j == final_j
    if initial_i == final_i && initial_j ~= final_j
        if initial_j < final_j
            direction = 'N';
        else
            direction = 'S';
        end
    elseif initial_i ~= final_i && initial_j == final_j
        if initial_i < final_i
            direction = 'E';
        else
            direction = 'W';
        end
    elseif initial_i == final_i && initial_j == final_j
        direction = '';
    end
elseif initial_i ~= final_i && initial_j ~= final_j
    if initial_i < final_i && initial_j < final_j
        direction = 'NE';
    elseif initial_i > final_i && initial_j < final_j
        direction = 'NW';
    elseif initial_i < final_i && initial_j > final_j
        direction = 'SE';
    elseif initial_i > final_i && initial_j > final_j
        direction = 'SW';
    end
end
end

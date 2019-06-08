function [ collisions_struct ] = collisions(instructions, initials, max_beats)
% Creates a detailed analysis of collisions for a set of instructions;
% Returns frames, marchers, and positions of each collision;

% Initializes positions struct;
positions = struct('x',[],'y',[]);
Y = length(initials);

% Positions now holds initial values for marcher positions;
for A = 1:Y
    positions(A).x = initials(A).i_initial;
    positions(A).y = initials(A).j_initial;
end

X = length(instructions);

% Initializes collisions_struct
collisions_struct = struct('frame',[],'marcher_1',[],'marcher_2',[],'location',[]);

% Big nasty expensive nested for loops fill up collisions_struct
for B = 1:max_beats
    for J = 1:X
        if(instructions(J).wait>0)
            instructions(J).wait = instructions(J).wait - 2;
        else
            % Oh wow a switch statement in the middle of the nest!
            % Takes in direction and simulates marcher movement;
            switch instructions(J).direction
                case '.'
                case 'N'
                    if instructions(J).j_target > positions(J).y
                        positions(J).y = positions(J).y + 1;
                    end
                case 'S'
                    if instructions(J).j_target < positions(J).y
                        positions(J).y = positions(J).y - 1;
                    end
                case 'E'
                    if instructions(J).i_target > positions(J).x
                        positions(J).x = positions(J).x + 1;
                    end
                case 'W'
                    if instructions(J).i_target < positions(J).x
                        positions(J).x = positions(J).x - 1;
                    end
                case 'NE'
                    if instructions(J).j_target > positions(J).y
                        positions(J).y = positions(J).y + 1;
                    elseif instructions(J).i_target > positions(J).x
                        positions(J).x = positions(J).x + 1;
                    end
                case 'EN'
                    if instructions(J).i_target > positions(J).x
                        positions(J).x = positions(J).x + 1;
                    elseif instructions(J).j_target > positions(J).y
                        positions(J).y = positions(J).y + 1;
                    end
                case 'NW'
                    if instructions(J).j_target > positions(J).y
                        positions(J).y = positions(J).y + 1;
                    elseif instructions(J).i_target < positions(J).x
                        positions(J).x = positions(J).x - 1;
                    end
                case 'WN'
                    if instructions(J).i_target < positions(J).x
                        positions(J).x = positions(J).x - 1;
                    elseif instructions(J).j_target > positions(J).y
                        positions(J).y = positions(J).y + 1;
                    end
                case 'SE'
                    if instructions(J).j_target < positions(J).y
                        positions(J).y = positions(J).y - 1;
                    elseif instructions(J).i_target > positions(J).x
                        positions(J).x = positions(J).x + 1;
                    end
                case 'ES'
                    if instructions(J).i_target > positions(J).x
                        positions(J).x = positions(J).x + 1;
                    elseif instructions(J).j_target < positions(J).y
                        positions(J).y = positions(J).y - 1;
                    end
                case 'SW'
                    if instructions(J).j_target < positions(J).y
                        positions(J).y = positions(J).y - 1;
                    elseif instructions(J).i_target < positions(J).x
                        positions(J).x = positions(J).x - 1;
                    end
                case 'WS'
                    if instructions(J).i_target < positions(J).x
                        positions(J).x = positions(J).x - 1;
                    elseif instructions(J).j_target < positions(J).y
                        positions(J).y = positions(J).y - 1;
                    end
                otherwise
                    
            end
        end
    end
    % Every beat, we have more for loops to actually write
    % collisions_struct;
    for C = 1:X
        for D = 1:X
            if (D ~= C)
                xC = positions(C).x;
                yC = positions(C).y;
                xD = positions(D).x;
                yD = positions(D).y;
                if((xC == xD) && (yC == yD))
                    collisions_struct(end+1).frame = B;
                    collisions_struct(end).marcher_1 = C;
                    collisions_struct(end).marcher_2 = D;
                    collisions_struct(end).location = [xC, yC];
                end
            end
        end
    end
end
% Gets rid of that horrible blank first line;
collisions_struct(1) = [];
end
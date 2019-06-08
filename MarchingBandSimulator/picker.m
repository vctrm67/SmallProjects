function [final_instructions] = picker(instructions_list, max_beats, initials)
% Most expensive part of the run; Picks the set of instructiosn in
% instructions_list with the least collisions;

if(isempty(instructions_list))
    fprintf('\nBecause of this, the program will terminate.');
    final_instructions = 'Sorry.';
else
    % Positions is initialized;
    positions = struct('x',[],'y',[]);
    temp = instructions_list(1).instr;
    
    % Initial value of best count is a collision count we hope we never
    % reach...;
    best_count = 10000000000;
    X = length(instructions_list(1).instr);
    Z = X;
    Y = length(initials);
    
    % Positions holds the initial values of marcher positions;
    for A = 1:Y
        positions(A).x = initials(A).i_initial;
        positions(A).y = initials(A).j_initial;
    end
    
    % Big nasty nested expensive for loop (the same one you see in
    % collisions.m);
    for I = 1:length(instructions_list)
        count = 0;
        test = positions;
        for B = 1:max_beats
            for J = 1:X
                switch instructions_list(I).instr(J).direction
                    case '.'
                    case 'N'
                        if instructions_list(I).instr(J).j_target > test(J).y
                            test(J).y = test(J).y + 1;
                        end
                    case 'S'
                        if instructions_list(I).instr(J).j_target < test(J).y
                            test(J).y = test(J).y - 1;
                        end
                    case 'E'
                        if instructions_list(I).instr(J).i_target > test(J).x
                            test(J).x = test(J).x + 1;
                        end
                    case 'W'
                        if instructions_list(I).instr(J).i_target < test(J).x
                            test(J).x = test(J).x - 1;
                        end
                    case 'NE'
                        if instructions_list(I).instr(J).j_target > test(J).y
                            test(J).y = test(J).y + 1;
                        elseif instructions_list(I).instr(J).i_target > test(J).x
                            test(J).x = test(J).x + 1;
                        end
                    case 'EN'
                        if instructions_list(I).instr(J).i_target > test(J).x
                            test(J).x = test(J).x + 1;
                        elseif instructions_list(I).instr(J).j_target > test(J).y
                            test(J).y = test(J).y + 1;
                        end
                    case 'NW'
                        if instructions_list(I).instr(J).j_target > test(J).y
                            test(J).y = test(J).y + 1;
                        elseif instructions_list(I).instr(J).i_target < test(J).x
                            test(J).x = test(J).x - 1;
                        end
                    case 'WN'
                        if instructions_list(I).instr(J).i_target < test(J).x
                            test(J).x = test(J).x - 1;
                        elseif instructions_list(I).instr(J).j_target > test(J).y
                            test(J).y = test(J).y + 1;
                        end
                    case 'SE'
                        if instructions_list(I).instr(J).j_target < test(J).y
                            test(J).y = test(J).y - 1;
                        elseif instructions_list(I).instr(J).i_target > test(J).x
                            test(J).x = test(J).x + 1;
                        end
                    case 'ES'
                        if instructions_list(I).instr(J).i_target > test(J).x
                            test(J).x = test(J).x + 1;
                        elseif instructions_list(I).instr(J).j_target < test(J).y
                            test(J).y = test(J).y - 1;
                        end
                    case 'SW'
                        if instructions_list(I).instr(J).j_target < test(J).y
                            test(J).y = test(J).y - 1;
                        elseif instructions_list(I).instr(J).i_target < test(J).x
                            test(J).x = test(J).x - 1;
                        end
                    case 'WS'
                        if instructions_list(I).instr(J).i_target < test(J).x
                            test(J).x = test(J).x - 1;
                        elseif instructions_list(I).instr(J).j_target < test(J).y
                            test(J).y = test(J).y - 1;
                        end
                    otherwise
                        
                end
                
            end
            rem = struct('strx',[],'stry',[]);
            for C = 1:Z
                rem(C).strx = int2str(test(C).x);
                rem(C).stry = int2str(test(C).y);
            end
            
            % This part was taken from an internet source as cited in the
            % write up; Bassically, it eliminates duplicates in a struct; I
            % use this to eliminate duplicates in positions to find out how
            % many spot collisions we have;
            xi = {rem.strx};
            yi = {rem.stry};
            c = cellfun(@(f,g) [f g],xi', yi','un',0);
            [ii, ii] = unique(c,'stable');
            rem2 = rem(ii);
            count = count + (length(rem) - length(rem2));
        end
        if(count<best_count)
            temp = instructions_list(I).instr;
            best_count = count;
        end
    end
    final_instructions = temp;
end
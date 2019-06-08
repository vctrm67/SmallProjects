function [instructions] = directions(initials, instructions)
% Assigns directions to marchers based on the other stuff in instructions
% and initials;

for I = 1:length(instructions)
    if(instructions(I).i_target == initials(I).i_initial)
        if(instructions(I).j_target == initials(I).j_initial)
            instructions(I).direction = '.';
        elseif(instructions(I).j_target > initials(I).j_initial)
            instructions(I).direction = 'N';
        else
            instructions(I).direction = 'S';
        end
    elseif(instructions(I).i_target > initials(I).i_initial)
        if(instructions(I).j_target == initials(I).j_initial)
            instructions(I).direction = 'E';
        elseif(instructions(I).j_target > initials(I).j_initial)
            instructions(I).direction = 'NE';
        else
            instructions(I).direction = 'SE';
        end
    else
        if(instructions(I).j_target == initials(I).j_initial)
            instructions(I).direction = 'W';
        elseif(instructions(I).j_target > initials(I).j_initial)
            instructions(I).direction = 'NW';
        else
            instructions(I).direction = 'SW';
        end
    end
end
end
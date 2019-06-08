function [instructions] = wait_times(instructions, initials, max_beats)
% This was never finished;

% Deletes duplicate collisions (14 collides with 43 and 43 collides with
% 14 just becomes 14 collides with 43);
col_struct = collisions(instructions, initials, max_beats);
temp = struct('frame',[],'marcher_1',[],'marcher_2',[],'location',[]);
for I = 1:col_struct(end).frame
    temp2 = struct('frame',[],'marcher_1',[],'marcher_2',[],'location',[]);
    for J = 1:length(col_struct)
        if(col_struct(J).frame == I)
            temp2(end+1) = col_struct(J);
        end
    end
    temp2(1) = [];
    temp = [temp,temp2(1:(length(temp2)/2))];
end
temp(1) = [];
col_struct = temp;

% Makes wait times equal to number of collisions (didn't work);
for I = 1:length(col_struct)
    instructions(col_struct(I).marcher_1).wait = instructions(col_struct(I).marcher_1).wait + 1;
end

% Makes wait times even numbers;
for I = 1:length(instructions)
    if(mod(instructions(I).wait,2)==1)
    instructions(I).wait = instructions(I).wait + 1;
    end
end
end
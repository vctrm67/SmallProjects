function [instructions_list] = direction_plus(instructions_list)
% Adds variation to directions;

% If the input is empty, then we can't really do anything;
if(isempty(instructions_list))
    fprintf('Our algorithms were not able to come up with instructions that fit with max_beats.');
    
% Execute function if not empty;    
else
len1 = length(instructions_list);
len2 = length(instructions_list(1).instr);

% Diversifies diversifiable directions;
for N = 1:len1
    temp_instr = instructions_list(N).instr;
    for I = 1:len2
        temp_dir = temp_instr(I).direction;
        switch temp_dir
            case 'NW'
                temp = struct('instr',[]);
                temp(1).instr = temp_instr;
                temp(1).instr(I).direction = 'WN';
                instructions_list = [instructions_list,temp];
            case 'NE'
                temp = struct('instr',[]);
                temp(1).instr = temp_instr;
                temp(1).instr(I).direction = 'EN';
                instructions_list = [instructions_list,temp];
            case 'SW'
                temp = struct('instr',[]);
                temp(1).instr = temp_instr;
                temp(1).instr(I).direction = 'WS';
                instructions_list = [instructions_list,temp];
            case 'SE'
                temp = struct('instr',[]);
                temp(1).instr = temp_instr;
                temp(1).instr(I).direction = 'ES';
                instructions_list = [instructions_list,temp];
            otherwise
        end
    end
end
end
end
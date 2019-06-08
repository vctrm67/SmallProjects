function [ instructions ] = IJAssign(initials, targets, instructions)
% Sorts both the initial positions and the targets positions with 
%field sorting of structs, first according to the ?i? values and then 
%according to the ?j? values; Then matches each member in intials with its 
%corresponding member in targets

%Sorts initials;
initials_fields = fieldnames(initials);
initials_cell = struct2cell(initials);
size_initial = size(initials_cell);
initials_cell = reshape(initials_cell, size_initial(1), []);
initials_cell = initials_cell';
initials_cell = sortrows(initials_cell, 1);
for I = 1:length(initials_cell)
    count = 0;
    i_temp = initials_cell{I,1,1};
    for J = I+1:length(initials_cell)
        if(initials_cell{J,1,1} == i_temp)
            count = count + 1;
        end
    end
    if(count>0)
        temp = initials_cell(I:count+I,:,:);
        temp = sortrows(temp, 2);
        initials_cell(I:count+I,:,:) = temp;
        I = I + count;
    end
end
initials_cell2 = reshape(initials_cell', size_initial);
initials_ijsort = cell2struct(initials_cell2, initials_fields, 1);

% Sorts targets;
targets_fields = fieldnames(targets);
targets_cell = struct2cell(targets);
size_target = size(targets_cell);
targets_cell = reshape(targets_cell, size_target(1), []);
targets_cell = targets_cell';
targets_cell = sortrows(targets_cell, 1);
for I = 1:length(targets_cell)
    count = 0;
    i_temp = targets_cell{I,1,1};
    for J = I+1:length(targets_cell)
        if(targets_cell{J,1,1} == i_temp)
            count = count + 1;
        end
    end
    if(count>0)
        temp = targets_cell(I:count+I,:,:);
        temp = sortrows(temp, 2);
        targets_cell(I:count+I,:,:) = temp;
        I = I + count;
    end
end
targets_cell2 = reshape(targets_cell', size_target);
targets_ijsort = cell2struct(targets_cell2, targets_fields, 1);

% Assigns targets
for I = 1:length(instructions)
    N = initials_ijsort(I).number;
    instructions(N).i_target = targets_ijsort(I).i;
    instructions(N).j_target = targets_ijsort(I).j;
end
end
function [instructions] = OptAssign(initial_formation, target_formation)
%Assigns target locations to marchers

target_formation2 = target_formation;
initial_formation2 = initial_formation;
n_bandmembers = sum(sum(target_formation));
instructions = struct('i_target',[],'j_target',[],'wait',[],'direction',[]);
instructions = repmat(instructions,1,n_bandmembers);

for i = 1:size(target_formation2, 1)
    for j = 1:size(target_formation2, 2)
        if target_formation2(i, j) ~= 0 && initial_formation2(i, j) ~= 0
            marcherNumber = initial_formation2(i, j);
            instructions(marcherNumber).i_target = i;
            instructions(marcherNumber).j_target = j;
            instructions(marcherNumber).wait = 0;
            instructions(marcherNumber).direction = '';
            target_formation2(i, j) = 0;
            initial_formation2(i, j) = 0;
        end
    end
end

while nnz(initial_formation2) ~= 0
    n_bandmembers = sum(sum(target_formation2));
    characteristics2 = struct('i_target',[],'j_target',[],'i_initial', [], 'j_initial', [], 'marcherNumber', [], 'distance', [], 'direction', []);

    k = 1;
    for i = 1:size(target_formation2, 1)
        for j = 1:size(target_formation2, 2)
            if target_formation2(i, j) ~= 0 && initial_formation2(i, j) == 0
                [marcher_i, marcher_j, distance] = findTarget(i, j, initial_formation2, target_formation2);
                marchNumber = initial_formation2(marcher_i, marcher_j);
                characteristics2(k).marcherNumber = marchNumber; 
                characteristics2(k).distance = distance;
                characteristics2(k).i_initial = marcher_i;
                characteristics2(k).j_initial = marcher_j;
                characteristics2(k).i_target = i;
                characteristics2(k).j_target = j;
                characteristics2(k).direction = findDirection(marcher_i, marcher_j, i, j);
                k = k + 1;
            end
        end
    end
    
    characteristics2;

    Afields = fieldnames(characteristics2);
    Acell = struct2cell(characteristics2);
    sz = size(Acell);
    Acell = reshape(Acell, sz(1), []);
    Acell = Acell';  
    Acell = sortrows(Acell, 6);
    Acell = reshape(Acell', sz);
    characteristics_sorted = cell2struct(Acell, Afields, 1);
    
    c = size(characteristics_sorted, 2);
    marcherNumber = characteristics_sorted(c).marcherNumber;
    a = characteristics_sorted(c).i_target;
    b = characteristics_sorted(c).j_target;
    march_i = characteristics_sorted(c).i_initial;
    march_j = characteristics_sorted(c).j_initial;
    distance = characteristics_sorted(c).distance;
    initial_formation2(march_i,  march_j) = 0;
    target_formation2(a, b) = 0;
    
    instructions(marcherNumber).i_target = a;
    instructions(marcherNumber).j_target = b;
    instructions(marcherNumber).direction = characteristics_sorted(c).direction;
    instructions(marcherNumber).wait = 0;
   
end
end

function [marcher_i, marcher_j, shortestDistance] = findTarget(target_i, target_j, initial_formation, target_formation)
%Takes in an final position, returns best possible target marcher position.

shortestDistance = 10000000;
marcher_i = 0;
marcher_j = 0;
for i = 1:size(initial_formation, 1)
    for j = 1:size(initial_formation, 2)
        if initial_formation(i, j) ~= 0 && target_formation(i, j) == 0
            Distance = sqrt((target_i - i)^2 + (target_j - j)^2);
            if Distance < shortestDistance
                shortestDistance = Distance;
                marcher_i = i;
                marcher_j = j;
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
        direction = '.';
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
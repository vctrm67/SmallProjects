%{
Okay so the point of this file is so we can test out our code with
arbitrary inputs without havign to call the entire function over and over
again. Just add your new target formation and initial formation in lines 11
and 12 and type 'test' into the editor. Also, it saves time in making your
test results every time you open matlab, as every time you open matlab,
your workspace is cleared. If this file becomes obsolete, we'll just get
rid of it. I just thought it held some time and effort benefits.
%}

target_formation = [1 0 0 1; 0 1 0 1; 1 0 1 0; 0 1 1 0];
initial_formation = [0 1 0 1; 0 1 1 0; 0 1 0 1; 1 1 0 0];

% Finds the number of bandmembers by adding up all the 1s in the target
n_bandmembers = sum(sum(target_formation));

% Makes a structure with the appropriate fields (without any actual data)
% and copies it nb times to get a 1 x nb array of structs
instructions = struct('i_target',[],'j_target',[],'wait',[],'direction',[]);
instructions = repmat(instructions,1,n_bandmembers);

% This code finds the i and j indices of each target location and stores
% them in i and j, respectively (note that i and j are not used as of yet!)
[i,j] = find(target_formation);

% Now it is up to you to figure out how to use the information provided
% to fill out the instructions struct array with appropriate values!

% Configures the target position data in instructions struct;
for I = 1:length(instructions)
    instructions(I).i_target = i(I);
    instructions(I).j_target = j(I);
end

% Sets [i,j] to locations of members in the intial formation;
[i,j] = find(initial_formation);

% initials now contains the intial locations of the band members;
for I = 1:length(instructions)
    initials(I).i_initial = i(I);
    initials(I).j_initial = j(I);
end

%Takes size of initial_formation; I'm assuming size of target formation is
%the same;
s = size(initial_formation);

% I figure this for loop may come in handy sometime; Cycles through initial
% formation and target formation;
for M = 1:s(1)
    for N = 1:s(2)
        % if (M,N) is unoccupied in initial formation...;
        if(initial_formation(M,N) == 0)
        % if (M,N) is occupied in both initial position and target
        % position...;
        elseif~(initial_formation(M,N) == target_formation(M,N))
            
        end
    end
end
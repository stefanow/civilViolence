%% This function creates a grid that contains the information on the 
% spatial positions as well as a cross reference array in order to find
% the position in the agentsmatrix

function gridcalc
% load variables
global grid
global gridpos
global agents
global x
global y

%set grids to 0
grid=zeros(x,y);
gridpos=zeros(x,y);

%assign the matrixposition to the grid and assign the agent type to spatial
%grid
for i=1:size(agents,1)
    grid(agents(i,2),agents(i,3))=agents(i,1);
    gridpos(agents(i,2),agents(i,3))=i;
end


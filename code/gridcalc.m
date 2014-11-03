function gridcalc
global grid
global gridpos
global agents
global x
global y

grid=zeros(x,y);
gridpos=zeros(x,y);

for i=1:size(agents,1)
    grid(agents(i,2),agents(i,3))=agents(i,1);
    gridpos(agents(i,2),agents(i,3))=i;
end


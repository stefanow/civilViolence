function civilianagents
global agents
global pos
global nog
N=zeros(nog+1,2);
for i=1:(nog+1)
    N(i,1)=agents(pos,5+3*(i-1)+1)-agents(pos,5+3*(i-1)+2);
    N(i,2)=agents(pos,5+3*(i-1)+1)-agents(pos,5+3*(i-1)+3);
end

action=zeros(nog,1);
for i=1:nog
    if (N(1,1)-N(i+1,1)>0)
        if (N(1,2)-N(i+1,2)>0)
            action(i)=1;
        end
    end
end

if (sum(action)~=0)
    ix=ceil(rand(1)*sum(action));
    j=0;
    for i=1:nog
        j=j+action(i);
        if (j==ix)
            agents(pos,1)=i+2;
        end
    end
    
end
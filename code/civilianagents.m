function civilianagents
global agents
global pos
global nog
global threshold
global civtogangs


%extract anger from agentsmatrix
N=zeros(nog+1,1);
for i=1:(nog+1)
    N(i)=agents(pos,5+i);
end

action=zeros(nog,1);
for i=1:nog
    if (N(1)-N(i+1)>threshold(i))
        action(i)=1;
    end
end

if (sum(action)~=0)
    ix=ceil(rand(1)*sum(action));
    
    j=0;
    
    for i=1:nog
        j=j+action(i);
        if (j==ix)
            
            agents(pos,1)=i+2;
            rn=randomvalue(0.5,0.25);
            eff=max(0,rn);
            eff=min(eff,1);
            rn=randomvalue(0.5,0.25);
            acc=max(0,rn);
            acc=min(acc,1);
            agents(pos,4)=eff;
            agents(pos,5)=acc;
            agents(pos,6:end)=0;
            civtogangs(i)=civtogangs(i)+1;
            
        end
    end
end
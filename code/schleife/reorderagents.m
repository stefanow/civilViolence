function reorderagents
global agents
global noag
global nog

agentsprime=zeros(size(agents));
noag=zeros(3+nog,1);
l=0;
for i=[1:(nog+2),0]
    m=0;
    for j=1:size(agents,1)
        if (agents(j,1)==i)
            l=l+1;
            m=m+1;
            agentsprime(l,:)=agents(j,:);
        end
    end
    if(i~=0)
        noag(i)=m;
    else
        noag(end)=m;
    end
end
agents=agentsprime;
noag
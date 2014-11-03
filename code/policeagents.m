function gangagents
global noagents
global agents
global nog
global gridpos
global k
global type
global pos
global R
global T


N=zeros(2+nog,1);
for i=3:(nog+2)
    N(i)=N(i)+(1-exp(-k(2)*noagents(i)/noagents(type)));
end
N=N*R;
N(1)=1000;
N(2)=1000;

N(noagents==0)=1000;
[minimum,posmin]=min(N);

if (minimum~=1000)
    if (minimum<T)
        [a,b]=getvision(pos,type,posmin);
        ix=ceil(rand(1)*a);
        abspos=gridpos(b(ix,1),b(ix,2));
        ra=rand(1);
        [a,b]=getvision(abspos,posmin,posmin);
        [c,d]=getvision(pos,type,type);
        proba=0;
        probb=0;
        
        for i=1:a
            proba=proba+agents(gridpos(b(i,1),b(i,2)),4);
        end
        for i=1:c
            probb=probb+agents(gridpos(d(i,1),d(i,2)),4);
        end
        
        if (ra<proba/(proba+probb))
            agents(pos,1)=0;
        else
            agents(abspos,1)=0;
        end
    else
        
    end
end
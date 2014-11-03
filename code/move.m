function move
global agents
global noag
global gridpos
par=0;
dummy=zeros(1,2);
if (noag(end)~=0)
    while(par==0)
        pos=ceil(rand(1)*sum(noag(1:(end-1))));
        if(agents(pos,1)~=0)
            [a,b]=getvision(pos,agents(pos,1),0);
            if (a~=0)
                n=ceil(rand(1)*a);
                poszero=gridpos(b(n,1),b(n,2));
                dummy=agents(poszero,2:3);
                agents(poszero,2:3)=agents(pos,2:3);
                agents(pos,2:3)=dummy;
                par=1;
            end
        end
    end
end
%% This function simulates the movement of the agents
% if there is a free position on the grid the function looks for a free
% position

function move
% load variables
global agents
global noag
global gridpos
global nog

%set par par variable to zero, while it is zero the loop works
par=0;

%initialize dummy variable needed for the switch of variables
dummy=zeros(1,2);

%check if there is a free position
if (noag(end)~=0)
    %loop until a movement was executed
    while(par==0)
        %choose random agent
        par2=0;
        while (par2==0)
            poszero=sum(noag(1:(end-1)))+ceil(rand(1)*noag(end));
            %choose agents around it
            tot=0;
            vec=[];
            
            for i=1:(nog+2)
                [a,b]=getvision(poszero,0,i);
                tot=tot+a;
                vec=[vec;b];
            end
            if (tot~=0)
                ix=ceil(rand(1)*tot);
                pos=gridpos(vec(ix,1),vec(ix,2));
                par2=1;
            end
        end
        
        %check if agent is not a free position (should never be the case)
        if(agents(pos,1)==0)
            error('free position was chosen')
        else
            [nofreepos,freepos]=getvision(pos,agents(pos,1),0);
            if (nofreepos~=0)
                %choose random free position of the available
                n=ceil(rand(1)*nofreepos);
                %get the row in matrix for the free position
                poszero=gridpos(freepos(n,1),freepos(n,2));
                
                %save the position of the free pos in dummy variable
                dummy=agents(poszero,2:3);
                %overwrite the free position
                agents(poszero,2:3)=agents(pos,2:3);
                %overwrite the original position
                agents(pos,2:3)=dummy;
                
                %actualize gridpos
                gridpos(agents(pos,2),agents(pos,3))=pos;
                gridpos(agents(poszero,2),agents(poszero,3))=poszero;
                
                %set par to 1 to stop loop
                par=1;
            end
        end
    end
end
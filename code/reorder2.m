function reorder2(position)
global agents
global noag
global nog
global gridpos

type=agents(position,1);

dummy=zeros(1,size(agents,2));
dummy=agents(position,1:end);
if (position<noag(1))
    typepos=1;
end
for i=1:(nog+1)
    if(position>sum(noag(1:i)))
        if (position<=sum(noag(1:i+1)))
            typepos=i+1;
        end
    end
end

if (typepos*type==0)
    error('zero position is exchanged')
end
if(typepos==type)
    error('same type')
end


typeposprime=typepos;
typeprime=type;
if (typepos>type)
    steps=typepos-type;
    for i=1:steps
        agents(position,:)=agents(sum(noag(1:(typepos-1)))+1,:);
        gridpos(agents(position,2),agents(position,3))=position;
        position=sum(noag(1:(typepos-1)))+1;
        typepos=typepos-1;
    end
    agents(position,:)=dummy;
    gridpos(agents(position,2),agents(position,3))=position;

elseif (typepos<type)
    steps=type-typepos;
    for i=1:steps
        agents(position,:)=agents(sum(noag(1:(typepos))),:);
        gridpos(agents(position,2),agents(position,3))=position;
        position=sum(noag(1:(typepos)));
        typepos=typepos+1;
    end
    if(typepos~=type) 
        error('reorder2')
    end
    agents(position,:)=dummy;
    gridpos(agents(position,2),agents(position,3))=position;
    
end

noag(typeposprime)=noag(typeposprime)-1;
noag(typeprime)=noag(typeprime)+1;
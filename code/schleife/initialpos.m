%% This function generates the intial spatial distribution of the agents
% on a grid according to th initial density distributions
% first a list is generated with all possible positions and a corresponding
% vector of the same length. The vector is filled with zeros. Then the
% number of agents is calculated and using a
% random-number*sum(h) gives the position in the h vector
% which corresponds to a gridposition. Then the position in h is set to 0

function initialpos
%load initial parameters
global x
global y
global noag
global agents
global nog
global meaneff
global meanacc
global sdacc
global sdeff
global initialanger


%set posvector and hvector to empty vectors
pos=[];
h=[];
for i=1:x
    for j=1:y
%add all possible positions and add a 0
        pos=[pos;i,j];
        h=[h,1];
    end
end

%number of positions
n=x*y;

%create a vector that contains the initial loop indexes for each agents
%type
minima=zeros(2+nog,1);
maxima=zeros(2+nog,1);
minima(1)=1;
maxima(1)=noag(1);
minima(2)=noag(1)+1;
maxima(2)=noag(2)+noag(1);
for i=3:(2+nog)
    minima(i)=sum(noag(1:2))+noag(3)*(i-3)+1;
    maxima(i)=sum(noag(1:2))+noag(3)*(i-2);
end

%find the positions in the h vector and assign the positions to agents
for j=1:(nog+2)
    for i=minima(j):maxima(j)
        ix=ceil(rand(1)*n);
        t=0;
        for l=1:x*y
            t=t+h(l);
            if (t==ix)
                agents(i,1)=j;
                agents(i,2)=pos(l,1);
                agents(i,3)=pos(l,2);
                h(l)=0;
                n=n-1;
                break
            end
        end
    end
end

%saves the remaining free positions to the agents matrix
i=maxima(end);
for j=1:size(h,2)
    if (h(j)==1)
        i=i+1;
        agents(i,2)=pos(j,1);
        agents(i,3)=pos(j,2);
    end
end

%assigns the initial parameters to police and gangs
for i=1:sum(noag(1:(end-1)))
    if (agents(i,1)==1)
        rn=randomvalue(meaneff(1),sdeff(1));
        eff=max(0,rn);
        eff=min(eff,1);
        rn=randomvalue(meanacc(1),sdacc(1));
        acc=max(0,rn);
        acc=min(acc,1);
        agents(i,4)=eff;
        agents(i,5)=acc;
    elseif (agents(i,1)~=2)
        if (agents(i,1)~=0)
            rn=randomvalue(meaneff(2),sdeff(2));
            eff=max(0,rn);
            eff=min(eff,1);
            rn=randomvalue(meanacc(2),sdacc(2));
            acc=max(0,rn);
            acc=min(acc,1);
            agents(i,4)=eff;
            agents(i,5)=acc;
        end
    end
end

%assigns the initial civilian values 
agents((noag(1)+1):sum(noag(1:2)),7:end)=initialanger(2);
agents((noag(1)+1):sum(noag(1:2)),6)=initialanger(1);



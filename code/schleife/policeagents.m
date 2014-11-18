%% This function simulates the police-gang interaction

function policeagents
global noagents
global agents
global nog
global gridpos
global k
global type
global pos
global R
global T
global attackprob
global change
global kills
global initialanger


%generate random number for decision for attack
pr=rand(1);

%execute attack if pr is smaller than attackprobability
if (pr<attackprob(1))
    
    %calculate risk for surrounding gang agents
    N=zeros(size(noagents));
    for i=3:(nog+2)
        N(i)=N(i)+(1-exp(-k(2)*noagents(i)/noagents(type)));
    end
    
    %add risk aversion
    N=N*R;
    
    %exclude risk for police and civilians
    N(1)=1000;
    N(2)=1000;
    
    %exclude risk for nonpresent
    N(noagents==0)=1000;
    
    %find risk minimum and the type
    [minimum,posmin]=min(N);
    
    %check if no risk is excluded
    if (minimum~=1000)
        %check if minimum is more than once present
        if (min(N([1:(posmin-1),(posmin+1):end]))==minimum)
            
            %initialize action
            action=zeros(size(N));
            
            %find all the minima
            for i=3:length(N)
                if (N(i)==minimum)
                    action(i)=1;
                    break
                end
            end
            
            %choose random minimum
            rando=rand(1);
            ix=ceil(rando*sum(action));
            
            %find chosen minimum and corresponding agent type
            j=0;
            for i=1:length(action)
                j=j+action(i);
                if (j==ix)
                    posmin=i;
                    break
                end
            end
        end
        
        %if minimum is smaller than threshold execute interaction
        if (minimum<T)
            %choose random of agent of selected type
            [a,b]=getvision(pos,type,posmin);
            ix=ceil(rand(1)*a);
            %extract absolute position of chosen agent
            abspos=gridpos(b(ix,1),b(ix,2));
            
            
            %extract accuracy
            accpos=agents(pos,5);
            accpos2=agents(abspos,5);
            
            %obtain civilians in vision
            [a,b]=getvision(pos,type,2);
            %simulate the angerincrease for the civilians
            for i=1:a;
                pr1=rand(1);
                if (pr1>accpos)
                    agents(gridpos(b(i,1),b(i,2)),6)=agents(gridpos(b(i,1),b(i,2)),6)+...
                        (1-agents(gridpos(b(i,1),b(i,2)),6))*change(1);
                end
            end
            
            %obtain civilians in vision
            [a,b]=getvision(abspos,posmin,2);
            %simulate the angerincrease for the civilians
            for i=1:a;
                pr1=rand(1);
                if (pr1>accpos2)
                    agents(gridpos(b(i,1),b(i,2)),4+posmin)=agents(gridpos(b(i,1),b(i,2)),4+posmin)+...
                        (1-agents(gridpos(b(i,1),b(i,2)),4+posmin))*change(2);
                end
            end
            
            %generate number of type1 agents in vision of agent1
            %and for type2
%             [a,b]=getvision(pos,type,type);
%             [c,d]=getvision(abspos,posmin,posmin);
            
            %             %initialize total efficiency
            %             proba=0;
            %             probb=0;
            %             for i=1:a
            %                 proba=proba+agents(gridpos(b(i,1),b(i,2)),4);
            %             end
            %             for i=1:c
            %                 probb=probb+agents(gridpos(d(i,1),d(i,2)),4);
            %             end
            proba=agents(pos,4);
            probb=agents(abspos,4);
            
            %execute attack
            ra=rand(1);
            if (ra<proba/(proba+probb))
                %create new civilian
                agents(abspos,1)=2;
                agents(abspos,4:5)=0;
                agents(pos,7:end)=initialanger(2);
                agents(pos,6)=initialanger(1);
                %update kills
                kills(1,posmin)=kills(1,posmin)+1;
                reorder2(abspos)
                
            else
                
            end
            
        end
    end
else
    %simulate help
    %check if civilians are in vicinity
    if (noagents(2)~=0)
        [a,b]=getvision(pos,type,2);
        ix=ceil(rand(1)*a);
        agents(gridpos(b(ix,1),b(ix,2)),6)=agents(gridpos(b(ix,1),b(ix,2)),6)*(1-change(1));
    end
end


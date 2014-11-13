%% clear all variables

clear all
close all
%% define parameters

%define grid size
global x
global y
x=10;
y=10;

%define no of gangs
global nog
nog=2;

%define density
%police
c(1)=0.2;
%civilians
c(2)=0.23;
%gangs
c(3)=0.23;

if (c(1)+c(2)+nog*c(3)>1)
    error('density too high')
end
%number agents
global noag
noag=floor(c*x*y);
for i=1:(nog-1)
    noag=[noag,noag(end)];
end
noag=[noag,x*y-sum(noag)];
initnoag=noag;
global v
%define vision of police
v(1)=1;
%civilians
v(2)=1;
%gang members;
v(3:nog+2)=1;

%max no of timesteps
global T
global R
Tstep=100000;
R=1;

T=1;
global threshold;
threshold=zeros(nog,1);
global attackprob;
attackprob(1:2)=1;
global change
change(1:2)=0.5;
global civtogangs;
civtogangs=zeros(nog,1);
typetot=zeros(nog+2,1);
sumanger=[];
global kills
kills=zeros(nog+2);

col=colormap;
col(1,:)=1;
%% define agents
global agents
agents=zeros(x*y,5+(nog+1));

% define probabilities for arrest
P(1)=0.9;
% define probabilities for arrest
P(2)=0.5;

% calculate k vector
global k
k=-log(1-P);


%% open for film
figure, set(gcf, 'Color','white')
set(gca, 'nextplot','replacechildren', 'Visible','off');
nFrames = Tstep+1;
vidObj = VideoWriter('agents.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 20;
open(vidObj);
figure('Renderer','zbuffer');
hold off;
colormap(col);
%% calculate cdf
global cdf
global xval
cdfcalc

%% assign positions too members

initialpos

%% create and display grid
global grid
global gridpos

gridcalc

f=figure(1);
imagesc(grid);
axis image
colorbar
colormap(col);
writeVideo(vidObj, getframe(gca));

%% time propagation
for timestep=1:Tstep
    
    % movement
    move
    
    % agent-agent interaction
    %choose random agent
    global noagents
    global pos
    global type
    pos=ceil(rand(1)*sum(noag(1:(end-1))));
    
    type=agents(pos,1);
    typetot(type)=typetot(type)+1;
    
    noagents=zeros(2+nog,1);
    for i=1:(2+nog)
        [a,b]=getvision(pos,type,i);
        noagents(i)=a;
    end
    noagents
    
    if (type==1)
        policeagents
    elseif (type==2)
        civilianagents
    elseif (type==0)
        error('type is zero')
    else
        gangagents
    end
    
    %reorder agents
    reorderagents
    
    %create grid
    gridcalc
    civtogangs
    f=figure(1);
    imagesc(grid);
    axis image
    sumanger=[sumanger;sum(agents(:,6:end))];
    writeVideo(vidObj, getframe(gca));
    
    if(initnoag-[sum(kills),0]-[0,0,civtogangs',0]~=noag')
        error('summe falsch')
    end
end
%% close video
close(gcf)

close(vidObj);

f=figure;
plot(1:size(sumanger,1),sumanger)
legend('police','gang1','gang2')

efficiency=zeros(nog+2,1);
efficiency(1)=sum(agents(1:noag(1),4));
for i=2:nog+2
efficiency(i)=sum(agents((sum(noag(1:(i-1)))+1):sum(noag(1:i)),4));
end
efficiency=efficiency./noag(1:(end-1))

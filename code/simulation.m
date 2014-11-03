%% clear all variables

clear all
close all
%% define parameters

%define grid size
global x
global y
x=15;
y=15;

%define no of gangs
global nog
nog=2;

%define density
%police
c(1)=0.1;
%civilians
c(2)=0.1;
%gangs
c(3)=0.3;

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
Tstep=10000;
R=1;

T=0.3;
%% define agents
global agents
agents=zeros(x*y,5+(nog+1)*3);
%efficiency
agents(:,4)=0.5;
%accuracy
agents(:,5)=0.5;
%civilian values 
agents(:,6:end)=rand(size(agents(:,6:end)));

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
    
    noagents=zeros(2+nog,1);
    for i=1:(2+nog)
        [a,b]=getvision(pos,type,i);
        noagents(i)=a;
    end
    
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
    
    f=figure(1);
    imagesc(grid);
    axis image
    
    writeVideo(vidObj, getframe(gca));
end
%% close video
close(gcf)

close(vidObj);
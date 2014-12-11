clear all
close all
par=[];
runno=1
nog=2;
for i=1:1;
    fileID=fopen(sprintf('par_os_%i.txt',runno),'r')
    formatSpec='%f';
    scansize=[17, Inf];
    
    parprime=fscanf(fileID,formatSpec,scansize);
    parprime=parprime';
    par=[par;parprime];
    fclose('all')
end
par
angertot=[];
killstot=[];
civtogangstot=[];
noagtot=[];
n=2;
for i=1:n
    fileID1 = fopen(sprintf('anger_os_%i_simno_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f.txt',par(i,:)),'r');
    scansize=[nog+1, Inf];
    anger=fscanf(fileID1,formatSpec,scansize);
    anger=anger';
    angertot=[angertot,anger];
    fclose(fileID1);
    
    fileID2 = fopen(sprintf('civtoagents_os_%i_simno_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f.txt',par(i,:)),'r');
    scansize=[nog, Inf];
    civtogangs=fscanf(fileID2,formatSpec,scansize);
    civtogangs=civtogangs';
    civtogangstot=[civtogangstot,civtogangs];
    fclose(fileID2);
    
    fileID3 = fopen(sprintf('kills_os_%i_simno_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f.txt',par(i,:)),'r');
    scansize=[(nog+2)*(nog+2), Inf];
    kills=fscanf(fileID3,formatSpec,scansize);
    kills=kills';
    killstot=[killstot,kills];
    fclose(fileID3);
    
    fileID4 = fopen(sprintf('noagents_os_%i_simno_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f_%f.txt',par(i,:)),'r');
    scansize=[nog+3, Inf];
    noag=fscanf(fileID4,formatSpec,scansize);
    noag=noag';
    noagtot=[noagtot,noag];
    fclose(fileID4);
   
    
end

%%
n=3;
k=0:n-1;
k=k*n;

for i=1:nog+1
    f=figure;
    plot(angertot(:,k+i))
end




function initialpos
global x
global y
global noag
global agents
global nog
pos=[];
h=[];
for i=1:x
    for j=1:y
        pos=[pos;i,j];
        h=[h,1];
    end
end

n=x*y;
n=x*y;
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
i=maxima(end);
for j=1:size(h,2)
    if (h(j)==1)
        i=i+1;
        agents(i,2)=pos(j,1);
        agents(i,3)=pos(j,2);
    end
end
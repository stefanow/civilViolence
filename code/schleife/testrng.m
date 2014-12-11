clear all

global cdf
global xval

cdfcalc

values=-10:0.01:10;
bins=zeros(size(values));

for k=1:10000
    ix=randomvalue(0,0.5);
    for i=1:(length(values)-1)
        if (ix>values(i))
            if (ix<=values(i+1))
                bins(i)=bins(i)+1;
            end
        end
    end
end

f=figure;

bar(values,bins);
xlim([-2,2]);

min=0;
max=0;
for i=1:length(values)
    if (-0.5>values(i)) 
        min=i;
    end
    if (0.5>values(i)) 
        max=i;
    end
    
end

sum(bins(min:(max-1)))/sum(bins)
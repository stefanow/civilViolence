function [no,tab]=getvision(pos,type,type2)
global agents
global v
global gridpos
global x
global y

if (type~=agents(pos,1))
    error('type wrong in getvision')
end

boundx=zeros(2,1);
boundy=zeros(2,1);

boundx(1)=max(agents(pos,2)-v(type),1);
boundy(1)=max(agents(pos,3)-v(type),1);
boundx(2)=min(agents(pos,2)+v(type),x);
boundy(2)=min(agents(pos,3)+v(type),y);

no=0;
tab=[];
for ix=boundx(1):boundx(2)
    for iy=boundy(1):boundy(2)
        posprime=gridpos(ix,iy);
        if(agents(posprime,1)==type2)
            no=no+1;
            tab=[tab;agents(posprime,2:3)];
        end
    end
end

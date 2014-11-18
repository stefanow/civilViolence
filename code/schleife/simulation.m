%% clear all variables

clear all
simno=0;

for tre=0.0:0.3:0.6
    for attprob1=0.1:0.4:0.9
        for attprob2=0.1:0.4:0.9
            for chang1=0.1:0.3:0.6
                for chang2=0.1:0.3:0.6
                    for meanacc1=0.1:0.4:0.9
                        for meanacc2=0.1:0.4:0.9
                            for meaneff1=0.1:0.4:0.9
                                for meaneff2=0.1:0.4:0.9
                                    for initang1=0.1:0.4:0.9
                                        for initang2=0.1:0.4:0.9
                                            
                                            
                                            simno=simno+1;
                                            fileID1 = fopen(sprintf('anger_simno_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d.txt',simno,tre,attprob1,attprob2,chang1,chang2, meanacc1,meanacc2,meaneff1,meaneff2,initang1,initang2),'w')
                                            fileID2 = fopen(sprintf('civtoagents_simno_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d.txt',simno,tre,attprob1,attprob2,chang1,chang2, meanacc1,meanacc2,meaneff1,meaneff2,initang1,initang2),'w')
                                            fileID3 = fopen(sprintf('kills_simno_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d.txt',simno,tre,attprob1,attprob2,chang1,chang2, meanacc1,meanacc2,meaneff1,meaneff2,initang1,initang2),'w')
                                            fileID4 = fopen(sprintf('noagents_simno_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d_%d.txt',simno,tre,attprob1,attprob2,chang1,chang2, meanacc1,meanacc2,meaneff1,meaneff2,initang1,initang2),'w')
                                            
                                            %% define parameters
                                            
                                            %define grid size
                                            global x
                                            global y
                                            x=40;
                                            y=40;
                                            
                                            %define no of gangs
                                            global nog
                                            nog=2;
                                            
                                            %define density
                                            %police
                                            c(1)=0.1;
                                            %civilians
                                            c(2)=0.5;
                                            %gangs
                                            c(3)=(0.9-c(1)-c(2))/2;
                                            
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
                                            
                                            global v0
                                            v0=max(v);
                                            %max no of timesteps
                                            global T
                                            global R
                                            Tstep=100000;
                                            
                                            R=0.5;
                                            T=0.25;
                                            
                                            par=0;
                                            %%
                                            global threshold;
                                            threshold=ones(nog,1);
                                            threshold=threshold*tre;
                                            global attackprob;
                                            attackprob(1)=attprob1;
                                            attackprob(2)=attprob2;
                                            global change
                                            change(1)=chang1;
                                            change(2)=chang2;
                                            global civtogangs;
                                            civtogangs=zeros(nog,1);
                                            typetot=zeros(nog+2,1);
                                            sumanger=[];
                                            global kills
                                            kills=zeros(nog+2);
                                            
                                            % col=colormap;
                                            % col(1,:)=1;
                                            global meaneff
                                            global meanacc
                                            global sdacc
                                            global sdeff
                                            global initialanger
                                            meanacc(1)=meanacc1;
                                            meanacc(2)=meanacc2;
                                            meaneff(1)=meaneff1;
                                            meaneff(2)=meaneff2;
                                            sdacc(1)=0.25;
                                            sdacc(2)=0.25;
                                            sdeff(1)=0.25;
                                            sdeff(2)=0.25;
                                            initialanger(1)=initang1;
                                            initialanger(2)=initang2;
                                            
                                            output=1000;
                                            %% define agents
                                            global agents
                                            agents=zeros(x*y,5+(nog+1));
                                            
                                            % define probabilities for arrest
                                            P(1)=0.9;
                                            % define probabilities for kill
                                            P(2)=0.5;
                                            
                                            % calculate k vector
                                            global k
                                            k=-log(1-P);
                                            
                                            civtogangstime=[];
                                            noagtime=[];
                                            killstime=[];
                                            
                                            % %% open for film
                                            % figure, set(gcf, 'Color','white')
                                            % set(gca, 'nextplot','replacechildren', 'Visible','off');
                                            % nFrames = Tstep+1;
                                            % vidObj = VideoWriter('agents.avi');
                                            % vidObj.Quality = 100;
                                            % vidObj.FrameRate = 20;
                                            % open(vidObj);
                                            % figure('Renderer','zbuffer');
                                            % hold off;
                                            % colormap(col);
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
                                            
                                            % f=figure(1);
                                            % imagesc(grid);
                                            % axis image
                                            % caxis([0,nog+2])
                                            % colormap(col);
                                            % writeVideo(vidObj, getframe(gca));
                                            
                                            %% time propagation
                                            
                                            % if (par==1)
                                            %     figure, set(gcf, 'Color','white')
                                            %     set(gca, 'nextplot','replacechildren', 'Visible','off');
                                            %     nFrames = Tstep+1;
                                            %     vidObj = VideoWriter('agents.avi');
                                            %     vidObj.Quality = 100;
                                            %     vidObj.FrameRate = 20;
                                            %     open(vidObj);
                                            %     figure('Renderer','zbuffer');
                                            %     hold off;
                                            %     colormap(col);
                                            % end
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
                                                %noagents
                                                %     agents
                                                %     pause
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
                                                %reorderagents
                                                %     agents
                                                %     pause
                                                %create grid
                                                
                                                sumkills=sum(kills);
                                                %     if(mod(timestep,output)==0)
                                                %         gridcalc
                                                %         f=figure(1);
                                                %         imagesc(grid);
                                                %         axis image
                                                %         caxis([0,nog+2])
                                                %         colormap(col)
                                                %         writeVideo(vidObj, getframe(gca));
                                                %         civtogangs
                                                %         noag
                                                %         sum(kills)
                                                %     end
                                                fprintf(fileID1,'%s',sum(agents(:,6:end))/noag(2));
                                                fprintf(fileID1,'\n');
                                                for i=1:nog+2
                                                    fprintf(fileID3,'%s',kills(i,:));
                                                end
                                                fprintf(fileID3,'\n');
                                                fprintf(fileID4,'%s',noag);
                                                fprintf(fileID4,'\n');
                                                fprintf(fileID2,'%s',civtogangs');
                                                fprintf(fileID2,'\n');
                                                

                                                if (initnoag(1)~=noag(1))
                                                    error('police falsch')
                                                end
                                                if (initnoag(2)+sum(sum(kills))-sum(civtogangs)~=noag(2))
                                                    initnoag(2)+sum(sum(kills))-sum(civtogangs)
                                                    noag(2)
                                                    error('civilians falsch')
                                                end
                                                
                                                for i=3:(nog+2)
                                                    if (initnoag(i)+civtogangs(i-2)-sumkills(i)~=noag(i))
                                                        i
                                                        error('gang falsch')
                                                    end
                                                end
                                                if(initnoag(end)~=noag(end))
                                                    error('free pos falsch')
                                                end
                                                if (prod(noag(3:end))==0)
                                                    break
                                                end
                                                
                                            end
                                            par=1;
                                            %% close video
                                            % close(gcf)
                                            %
                                            % close(vidObj);
                                            %
                                            % f=figure;
                                            %
                                            % plot(1:size(sumanger,1),sumanger)
                                            % legend('police','gang1','gang2')
                                            % %%
                                            % f=figure;
                                            % title('kills')
                                            % plot(1:size(killstime,1),killstime(:,3:end))
                                            % legend('gang1','gang2')
                                            % %%
                                            % f=figure;
                                            % title('agents')
                                            % plot(1:size(noagtime,1),noagtime(:,1:(end-1)))
                                            % legend('police','civilians','gang1','gang2')
                                            % %%
                                            % f=figure;
                                            % title('civilians to gang')
                                            % plot(1:size(civtogangstime,1),civtogangstime)
                                            % legend('gang1','gang2')
                                            
                                            fclose('all')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end



%Define Boundary for the global plan
Xminglobal=0;
Xmaxglobal=200;
Yminglobal=0;
Ymaxglobal=200;
statobs1=[20 30 10 20];
rectangle('Position',statobs1,'FaceColor',[0 .5 .5]);
hold on
axis([0 200 0 200])


statobs2=[50 10 10 20];
rectangle('Position',statobs2,'FaceColor',[0 .5 .5]);
hold on
axis([0 200 0 200])
START_X=40;
START_Y=40;
GOAL_X=150;
GOAL_Y=150;

grid_len=10;

MAP_IDX=1;

for i=0:grid_len:Xmaxglobal
    for j=0:grid_len:Ymaxglobal
       %{
        if i==0
            i=1
        end
        
        if j==0
            j=1
        end
        %}
        MAP(MAP_IDX, 1)=i;
        MAP(MAP_IDX, 2)=j;
        MAP(MAP_IDX, 3)=2;
        MAP_IDX=MAP_IDX+1;
    end
    %disp('yo in here');
end
MAP_IDX=MAP_IDX-1;

OPEN=[];
CLOSED=[];
CLOSED_IDX=1;
OPEN_IDX=1;

OBS_COORD_LIST=[];
OBS_IDX=1;
OBS_COORD_LIST(OBS_IDX, 1)=statobs1(1);OBS_COORD_LIST(OBS_IDX, 2)=statobs1(2);% 20,30
OBS_IDX=OBS_IDX+1;
OBS_COORD_LIST(OBS_IDX, 1)=statobs1(1)+statobs1(3);OBS_COORD_LIST(OBS_IDX, 2)=statobs1(2)+statobs1(4);% 30,50
OBS_IDX=OBS_IDX+1;
OBS_COORD_LIST(OBS_IDX, 1)=statobs1(1)+10;OBS_COORD_LIST(OBS_IDX, 2)=statobs1(2);% 30,30
OBS_IDX=OBS_IDX+1;
OBS_COORD_LIST(OBS_IDX, 1)=statobs1(1)+10;OBS_COORD_LIST(OBS_IDX, 2)=statobs1(2)+10;% 30,40
OBS_IDX=OBS_IDX+1;
OBS_COORD_LIST(OBS_IDX, 1)=statobs1(1);OBS_COORD_LIST(OBS_IDX, 2)=statobs1(2)+10;% 20,40
OBS_IDX=OBS_IDX+1;
OBS_COORD_LIST(OBS_IDX, 1)=statobs1(1);OBS_COORD_LIST(OBS_IDX, 2)=statobs1(2)+20;% 20,40
OBS_IDX=OBS_IDX+1;
OBS_COORD_LIST(OBS_IDX, 1)=statobs2(1);OBS_COORD_LIST(OBS_IDX, 2)=statobs2(2);% 20,30
OBS_IDX=OBS_IDX+1;
OBS_COORD_LIST(OBS_IDX, 1)=statobs2(1)+statobs1(3);OBS_COORD_LIST(OBS_IDX, 2)=statobs2(2)+statobs2(4);% 30,50
OBS_IDX=OBS_IDX+1;
OBS_COORD_LIST(OBS_IDX, 1)=statobs2(1)+10;OBS_COORD_LIST(OBS_IDX, 2)=statobs2(2);% 30,30
OBS_IDX=OBS_IDX+1;
OBS_COORD_LIST(OBS_IDX, 1)=statobs2(1)+10;OBS_COORD_LIST(OBS_IDX, 2)=statobs2(2)+10;% 30,40
OBS_IDX=OBS_IDX+1;
OBS_COORD_LIST(OBS_IDX, 1)=statobs2(1);OBS_COORD_LIST(OBS_IDX, 2)=statobs2(2)+10;% 20,40
OBS_IDX=OBS_IDX+1;
OBS_COORD_LIST(OBS_IDX, 1)=statobs2(1);OBS_COORD_LIST(OBS_IDX, 2)=statobs2(2)+20;% 20,40


Optimal_path=a_star(OPEN, CLOSED, OPEN_IDX, CLOSED_IDX, OBS_COORD_LIST, OBS_IDX, MAP, MAP_IDX, START_X, START_Y, GOAL_X, GOAL_Y, Xminglobal, Xmaxglobal, Yminglobal, Ymaxglobal);

Optimal_path=flipud(Optimal_path);
path=[];

%state lattice primitive decision
curr_heading=0;
TurnRadius = 2;   
PathStep = -1;   
t1=0;
t2=5;
v1=4;
v2=4;
Optimal_path(1,3)=0;
Optimal_path(1,4)=0;
manu='x';

%dynamic obs path
obsx0=58;
obsy0=90;
obsvx0= 0;
obsvy0=-50/30;
dt=0.1;
DYN_IDX=1;
%{
for tobs=0:dt:60
    obsx0=obsx0 + obsvx0*dt;
    obsy0=obsy0 + obsvy0*dt;
    %disp(obsy0);
    
    dyn_obs_path(DYN_IDX,1)= obsx0;
    dyn_obs_path(DYN_IDX,2)= obsy0;
    dyn_obs_path(DYN_IDX,3)= tobs;
    
    DYN_IDX=DYN_IDX+1;
    
    
end
%}


for OPT_IDX=1:size(Optimal_path,1)-1
    
    Optimal_path(OPT_IDX,4)=t1;

        disp(OPT_IDX);
disp('!!!!!!!!!!!!!!!');
if OPT_IDX<size(Optimal_path,1)-1

[manu, next_manu]=find_direction(Optimal_path(OPT_IDX,1),Optimal_path(OPT_IDX,2),Optimal_path(OPT_IDX+1,1),Optimal_path(OPT_IDX+1,2),Optimal_path(OPT_IDX+2,1),Optimal_path(OPT_IDX+2,2)); 
disp(manu);
disp(next_manu);
disp('------------------');
next_heading=find_heading(manu,next_manu);
Optimal_path(OPT_IDX+1,3)=next_heading;
%path=dubins_curve([Optimal_path(OPT_IDX,1) Optimal_path(OPT_IDX,2) Optimal_path(OPT_IDX,3)]  ,[Optimal_path(OPT_IDX+1,1) Optimal_path(OPT_IDX+1,2) Optimal_path(OPT_IDX+1,3)], TurnRadius, PathStep);
temp_path=non_holo_path(Optimal_path(OPT_IDX,1), Optimal_path(OPT_IDX,2), Optimal_path(OPT_IDX,3), Optimal_path(OPT_IDX+1,1), Optimal_path(OPT_IDX+1,2), Optimal_path(OPT_IDX+1,3),v1,v2,t1,t2);

else
    Optimal_path(OPT_IDX+1,3)=curr_heading;
    %path=dubins_curve([Optimal_path(OPT_IDX,1) Optimal_path(OPT_IDX,2) Optimal_path(OPT_IDX,3)]  ,[Optimal_path(OPT_IDX+1,1) Optimal_path(OPT_IDX+1,2) Optimal_path(OPT_IDX+1,3)], TurnRadius, PathStep);
    temp_path=non_holo_path(Optimal_path(OPT_IDX,1), Optimal_path(OPT_IDX,2), Optimal_path(OPT_IDX,3), Optimal_path(OPT_IDX+1,1), Optimal_path(OPT_IDX+1,2), Optimal_path(OPT_IDX+1,3),v1,v2,t1,t2);

end
    path=[path; temp_path];
     
    curr_heading=next_heading;
    t1=t2;
    t2=t2+5;
    
end
OPT_IDX=OPT_IDX+1;
Optimal_path(OPT_IDX,4)=t1+5;

%Trajectory of obstacle for head on collision
dyn_obs_path=flipud(path);  
t=0;
for dyn_idx=1:1:size(dyn_obs_path)
dyn_obs_path(dyn_idx,3)= dyn_obs_path(dyn_idx,3)+pi;
dyn_obs_path(dyn_idx,4)= t;
t=t+0.1;
end


collision_avoided=false;

%for OPT_IDX=1:size(Optimal_path,1)-1


j=size(path,1);
k=size(dyn_obs_path,1);
 %Plot the Optimal Path!
 p=plot(path(1,1),path(1,2),'bo');
 dy=plot(dyn_obs_path(1,1),dyn_obs_path(1,2),'bo');
 %j=j+1;
 g=max(j,k);
 for i=1:1:g
  %pause(.00001);
  j=size(path,1);
  g=max(j,k);
  
  if i<=j
     
  set(p,'XData',path(i,1),'YData',path(i,2));
  plot(path(:,1),path(:,2));
  
  %disp(round(path(i,1)));
  %disp(round(path(i,2)));
  end
  
  if(i<=k)
  set(dy,'XData',dyn_obs_path(i,1),'YData',dyn_obs_path(i,2));
  %plot(dyn_obs_path(:,1),dyn_obs_path(:,2));
  end
  
  local_rect=[path(i,1)-30 path(i,1)-30 path(i,1)+30 path(i,1)+30 path(i,1)-30; path(i,2)-30 path(i,2)+30 path(i,2)+30 path(i,2)-30 path(i,2)-30];
  a=line(local_rect(1,:),local_rect(2,:));
  drawnow;
  
  is_present_dyn_obs= check_for_dyn_obs(path(i,1)-30,path(i,1)+30,path(i,2)-30,path(i,2)+30,dyn_obs_path(i,1),dyn_obs_path(i,2));
  
  
  if (is_present_dyn_obs==true && collision_avoided==false)
     idx=i;
     [dyn_coll_x1,dyn_coll_x2,dyn_coll_y1,dyn_coll_y2,coll_time] =  dyn_coll_detection(path, dyn_obs_path, idx);
     dyn_obs = [dyn_coll_x1,dyn_coll_x2,dyn_coll_y1,dyn_coll_y2, coll_time];
     disp('Initial Dynamic collision detection done');
     dyn_obs_x=[dyn_coll_x1 dyn_coll_x2 dyn_coll_x2 dyn_coll_x1 dyn_coll_x1];
     dyn_obs_y=[dyn_coll_y1 dyn_coll_y1 dyn_coll_y2 dyn_coll_y2 dyn_coll_y1];
     pseudo_obs= line(dyn_obs_x,dyn_obs_y,'Color','r');
     
     % 1st strategy to avoid collision- check if stopping and proceeding avoids the collision
     
     
     
     for OPT_IDX=1:1:size(Optimal_path)-1
         if ((Optimal_path(OPT_IDX,1)==dyn_obs(1) && Optimal_path(OPT_IDX,2)==dyn_obs(3))|| (Optimal_path(OPT_IDX,1)==dyn_obs(2) && Optimal_path(OPT_IDX,2)==dyn_obs(3)) || (Optimal_path(OPT_IDX,1)==dyn_obs(2) && Optimal_path(OPT_IDX,2)==dyn_obs(4)) || (Optimal_path(OPT_IDX,1)==dyn_obs(1) && Optimal_path(OPT_IDX,2)==dyn_obs(4)))
             stop_point_x=Optimal_path(OPT_IDX,1);
             stop_point_y=Optimal_path(OPT_IDX,2);
             stop_point_IDX= OPT_IDX;
             stop_time=Optimal_path(OPT_IDX,4);
             time_to_stop=coll_time-stop_time;
             break
         end
     end
     disp('Stop point calculated');
         
     
    new_path= check_stop_avoidance(path, stop_time, time_to_stop,idx);
    disp('New path after stopping is found');
    [new_coll_x1,new_coll_x2,new_coll_y1,new_coll_y2,coll_time] =  dyn_coll_detection(new_path, dyn_obs_path, idx);
    disp('Final Dynamic collision detection done');
    disp('coll_time is : ');
    disp(coll_time);
    if coll_time==inf
        collision_avoided=true;
        path=new_path;
    
    end
     
   % start code to replan
     
    if collision_avoided==false  
     
       
     %adding obstacle coordinates to closed list fr A*
     OBS_IDX=OBS_IDX+1;
     OBS_COORD_LIST(OBS_IDX, 1)=dyn_obs(1);OBS_COORD_LIST(OBS_IDX, 2)=dyn_obs(3);
     OBS_IDX=OBS_IDX+1;
     OBS_COORD_LIST(OBS_IDX, 1)=dyn_obs(2);OBS_COORD_LIST(OBS_IDX, 2)=dyn_obs(3);
     OBS_IDX=OBS_IDX+1;
     OBS_COORD_LIST(OBS_IDX, 1)=dyn_obs(2);OBS_COORD_LIST(OBS_IDX, 2)=dyn_obs(4);
     OBS_IDX=OBS_IDX+1;
     OBS_COORD_LIST(OBS_IDX, 1)=dyn_obs(1);OBS_COORD_LIST(OBS_IDX, 2)=dyn_obs(4);
     
     for OPT_IDX=1:1:size(Optimal_path)-1
         if(path(i,4)>=Optimal_path(OPT_IDX,4) && path(i,4)<=Optimal_path(OPT_IDX+1,4))
             replanning_start_x=Optimal_path(OPT_IDX+1,1);
             replanning_start_y=Optimal_path(OPT_IDX+1,2);
             replanning_start_time=Optimal_path(OPT_IDX+1,4);
             replanning_start_IDX=OPT_IDX+1;
             break
         end
                 
     end
     OBS_IDX=OBS_IDX+1;
     OBS_COORD_LIST(OBS_IDX, 1)=Optimal_path(replanning_start_IDX-1,1);OBS_COORD_LIST(OBS_IDX, 2)=Optimal_path(replanning_start_IDX-1,2);
     
     new_path_1=[];
     new_path_2=[];
     new_path_3=[];
     new_path=[];
     
     
         
     
     replanning_stop_x=Optimal_path(stop_point_IDX+3, 1);
     replanning_stop_y=Optimal_path(stop_point_IDX+3, 2);
     replanning_stop_time=Optimal_path(stop_point_IDX+3, 4);
     
     for path_IDX=1:1:size(path)-1
         if path(path_IDX,4)<replanning_start_time
             new_path_1=[new_path_1;path(path_IDX,:)];
             
         else if path(path_IDX,4)>replanning_stop_time
             new_path_3=[new_path_3;path(path_IDX,:)];
             end
         end
     end
     
             
     %OBS_IDX=OBS_IDX+1; 
     replanned_path=a_star(OPEN, CLOSED, OPEN_IDX, CLOSED_IDX, OBS_COORD_LIST, OBS_IDX, MAP, MAP_IDX, replanning_start_x, replanning_start_y, replanning_stop_x, replanning_stop_y, Xminglobal, Xmaxglobal, Yminglobal, Ymaxglobal);
     replanned_path=flipud(replanned_path);
     
     
     
     curr_heading=Optimal_path(replanning_start_IDX,3);
    deltaT=(Optimal_path(stop_point_IDX+3,4)-Optimal_path(replanning_start_IDX,4))/(size(replanned_path,1)-1);
    t1=Optimal_path(replanning_start_IDX,4);
    t2=t1+deltaT;
    v1=4;
    v2=4;
    replanned_path(1,3)=curr_heading;
    replanned_path(1,4)=t1;
    manu='x';
     
     for replanning_IDX=1:size(replanned_path,1)-1
    
            replanned_path(OPT_IDX,4)=t1;

                disp(replanning_IDX);
        disp('@@@@@@@@@@@@@@@@@@@@@@@@');
        if replanning_IDX<size(replanned_path,1)-1

        [manu, next_manu]=find_direction(replanned_path(replanning_IDX,1),replanned_path(replanning_IDX,2),replanned_path(replanning_IDX+1,1),replanned_path(replanning_IDX+1,2),replanned_path(replanning_IDX+2,1),replanned_path(replanning_IDX+2,2)); 
        disp(manu);
        disp(next_manu);
        disp('------------------');
        next_heading=find_heading(manu,next_manu);
        replanned_path(replanning_IDX+1,3)=next_heading;
        %path=dubins_curve([Optimal_path(OPT_IDX,1) Optimal_path(OPT_IDX,2) Optimal_path(OPT_IDX,3)]  ,[Optimal_path(OPT_IDX+1,1) Optimal_path(OPT_IDX+1,2) Optimal_path(OPT_IDX+1,3)], TurnRadius, PathStep);
        temp_path=non_holo_path(replanned_path(replanning_IDX,1), replanned_path(replanning_IDX,2), replanned_path(replanning_IDX,3), replanned_path(replanning_IDX+1,1), replanned_path(replanning_IDX+1,2), replanned_path(replanning_IDX+1,3),v1,v2,t1,t2);

        else
            replanned_path(replanning_IDX+1,3)=Optimal_path(stop_point_IDX+3, 3);
            %path=dubins_curve([Optimal_path(OPT_IDX,1) Optimal_path(OPT_IDX,2) Optimal_path(OPT_IDX,3)]  ,[Optimal_path(OPT_IDX+1,1) Optimal_path(OPT_IDX+1,2) Optimal_path(OPT_IDX+1,3)], TurnRadius, PathStep);
            temp_path=non_holo_path(replanned_path(replanning_IDX,1), replanned_path(replanning_IDX,2), replanned_path(replanning_IDX,3), replanned_path(replanning_IDX+1,1), replanned_path(replanning_IDX+1,2), replanned_path(replanning_IDX+1,3),v1,v2,t1,t2);

        end
            new_path_2=[new_path_2; temp_path];

            curr_heading=next_heading;
            t1=t2;
            t2=t2+deltaT;

     end
    replanning_IDX=replanning_IDX+1;
    replanned_path(replanning_IDX,4)=t1+deltaT;

        
        
     new_path= [new_path_1;new_path_2;new_path_3];
     
    [new_coll_x1,new_coll_x2,new_coll_y1,new_coll_y2,coll_time] =  dyn_coll_detection(new_path, dyn_obs_path, idx);
    disp('Dynamic collision detection after replanning done');
    disp('coll_time is : ');
    disp(coll_time);
    if coll_time==inf
        collision_avoided=true;
        path=new_path;
    
    end
     
     
    end
     
  if path(i,4)>stop_time+time_to_stop
      delete (pseudo_obs);
  end
  end
  
  
 
 
  
 axis([0 200 0 200])
 delete(a);
 end
 


%end
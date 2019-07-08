function Optimal_path=a_star(OPEN, CLOSED, OPEN_IDX, CLOSED_IDX, OBS_COORD_LIST, OBS_IDX, MAP, MAP_IDX, START_X, START_Y, GOAL_X, GOAL_Y, Xminglobal, Xmaxglobal, Yminglobal, Ymaxglobal)

for j=1:OBS_IDX
    mapidx=find_map_idx(OBS_COORD_LIST(j,1),OBS_COORD_LIST(j,2), MAP_IDX,MAP);
    MAP(mapidx,3)=-1;
    %if mapidx==25
    %disp('checking if obstacle at 20 20 is alloted');
    %disp(MAP(mapidx,3));
    %end
    CLOSED(CLOSED_IDX,1)=MAP(mapidx,1);
    CLOSED(CLOSED_IDX,2)=MAP(mapidx,2);
    CLOSED_IDX= CLOSED_IDX+1;
    %disp('OBS idx is: ');
    %disp(j);
    
    %disp('Mapidx is: ');
    %disp(mapidx);
    
end
CLOSED_IDX=size(CLOSED,1);
%open with start node
xNode=START_X;
yNode=START_Y;
path_cost=0;%start to current
goal_distance=distance(xNode,yNode,GOAL_X,GOAL_Y);%heuristics
OPEN(OPEN_IDX,:)=insert_open(xNode,yNode,xNode,yNode,path_cost,goal_distance,goal_distance);
OPEN(OPEN_IDX,1)=0;

CLOSED(CLOSED_IDX,1)=xNode;
CLOSED(CLOSED_IDX,2)=yNode;
NoPath=1;

% START ALGORITHM

while((xNode ~= GOAL_X || yNode ~= GOAL_Y) && NoPath == 1)

 exp_array=expand_array(xNode,yNode,path_cost,GOAL_X,GOAL_Y,CLOSED,Xmaxglobal,Ymaxglobal);
 exp_count=size(exp_array,1);
 %UPDATE LIST OPEN WITH THE SUCCESSOR NODES
 %OPEN LIST FORMAT
 %--------------------------------------------------------------------------
 %IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
 %--------------------------------------------------------------------------
 %EXPANDED ARRAY FORMAT
 %--------------------------------
 %|X val |Y val ||h(n) |g(n)|f(n)|
 %--------------------------------
 for i=1:exp_count
    flag=0;
    for j=1:OPEN_IDX
        if(exp_array(i,1) == OPEN(j,2) && exp_array(i,2) == OPEN(j,3) )
            OPEN(j,8)=min(OPEN(j,8),exp_array(i,5)); %#ok<*SAGROW>
            if OPEN(j,8)== exp_array(i,5)
                %UPDATE PARENTS,gn,hn
                OPEN(j,4)=xNode;
                OPEN(j,5)=yNode;
                OPEN(j,6)=exp_array(i,3);
                OPEN(j,7)=exp_array(i,4);
            end;%End of minimum fn check
            flag=1;
        end;%End of node check
%         if flag == 1
%             break;
    end;%End of j for
    if flag == 0
        OPEN_IDX = OPEN_IDX+1;
        OPEN(OPEN_IDX,:)=insert_open(exp_array(i,1),exp_array(i,2),xNode,yNode,exp_array(i,3),exp_array(i,4),exp_array(i,5));
     end;%End of insert new element into the OPEN list
 end;%End of i for
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %END OF WHILE LOOP
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Find out the node with the smallest fn 
  index_min_node = min_fn(OPEN,OPEN_IDX,START_X,START_Y);
  if (index_min_node ~= -1)    
   %Set xNode and yNode to the node with minimum fn
   xNode=OPEN(index_min_node,2);
   yNode=OPEN(index_min_node,3);
   path_cost=OPEN(index_min_node,6);%Update the cost of reaching the parent node
  %Move the Node to list CLOSED
  CLOSED_IDX=CLOSED_IDX+1;
  CLOSED(CLOSED_IDX,1)=xNode;
  CLOSED(CLOSED_IDX,2)=yNode;
  OPEN(index_min_node,1)=0;
  else
      %No path exists to the Target!!
      NoPath=0;%Exits the loop!
  end;%End of index_min_node check
end;%End of While Loop

disp('MAP 25 after a star after while loop: ');
     disp(MAP(25,3));
     
     
i=size(CLOSED,1);
Optimal_path=[];
xval=CLOSED(i,1);
yval=CLOSED(i,2);
i=1;
Optimal_path(i,1)=xval;
Optimal_path(i,2)=yval;
i=i+1;

if ( (xval == GOAL_X) && (yval == GOAL_Y))
    inode=0;
   %Traverse OPEN and determine the parent nodes
   parent_x=OPEN(node_index(OPEN,xval,yval),4);%node_index returns the index of the node
   parent_y=OPEN(node_index(OPEN,xval,yval),5);
   
   while( parent_x ~= START_X || parent_y ~= START_Y)
           Optimal_path(i,1) = parent_x;
           Optimal_path(i,2) = parent_y;
           %Get the grandparents:-)
           inode=node_index(OPEN,parent_x,parent_y);
           parent_x=OPEN(inode,4);%node_index returns the index of the node
           parent_y=OPEN(inode,5);
           i=i+1;
    end;
    Optimal_path(i,1)=START_X;
    Optimal_path(i,2)=START_Y;
    
    disp('MAP 25 after second while: ');
     disp(MAP(25,3));
%  j=size(Optimal_path,1);
%  %Plot the Optimal Path!
%  p=plot(Optimal_path(j,1)+.5,Optimal_path(j,2)+.5,'bo');
%  j=j-1;
%  for i=j:-1:1
%   pause(.25);
%   set(p,'XData',Optimal_path(i,1)+.5,'YData',Optimal_path(i,2)+.5);
%  drawnow ;
%  axis([0 101 0 101])
%  end;
%  plot(Optimal_path(:,1)+.5,Optimal_path(:,2)+.5);
 
else
 pause(1);
 h=msgbox('Sorry, No path exists to the Target!','warn');
 uiwait(h,5);
end

end
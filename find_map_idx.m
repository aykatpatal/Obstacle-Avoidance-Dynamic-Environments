function idx = find_map_idx(x,y,MAP_SZ,MAP)
%This function finds the index of the coordinates of the obstacles
%disp(x);
%disp(y);
for i=1:1:MAP_SZ
   
    if(MAP(i,1)==x && MAP(i,2)==y)
        %disp('hello');
        idx=i;
    end
end
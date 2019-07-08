function [x1, x2, y1, y2, coll_time] = dyn_coll_detection(path, dyn_obs_path, idx)

disp('Inside the dynamic collision detection function');
path_size = size(path);
dyn_path_size = size(dyn_obs_path);

g=min(path_size, dyn_path_size);

for i=idx:1:g
    if sqrt((path(i,1)-dyn_obs_path(i,1))^2 + (path(i,2)-dyn_obs_path(i,2))^2)<3
        coll_detected=true;
        x1= path(i,1)-mod(path(i,1),10);
        x2=x1+10;
        y1=path(i,2)-mod(path(i,2),10);
        y2=y1+10;
        coll_time=path(i,4);
        
       
        break
    else 
        x1=inf;
        x2=inf;
        y1=inf;
        y2=inf;
        coll_time=inf;
    end

end
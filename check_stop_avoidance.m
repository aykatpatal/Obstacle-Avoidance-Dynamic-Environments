function new_path = check_stop_avoidance(path, stop_time, time_to_stop,idx)
new_path=[];
path_append=[];
disp('Inside the check_stop_avoidance function');

for i=1:1:size(path)
    if (path(i,4)<=stop_time)
        new_path=[new_path;path(i,:)];
        last_pos=path(i,:);
    else 
        path_append=[path_append; path(i,:)];
    end    
end


for i=stop_time+0.1:0.1:stop_time+time_to_stop
    last_pos(4)=i;
    new_path=[new_path;last_pos];
    
end

for i=1:1:size(path_append)
    
    dt=i*0.1;
    path_append(i,4)=stop_time+time_to_stop+dt;
    
end
 
 new_path=[new_path;path_append];
 disp('Completed the check_stop_avoidance function');
    

end
function dyn_obs_inside_window = check_for_dyn_obs(x1,x2,y1,y2,dyn_x,dyn_y)

if( dyn_x<=x2 && dyn_x>=x1 )&&(dyn_y<=y2 && dyn_y>=y1)
    dyn_obs_inside_window = true;
    
else dyn_obs_inside_window = false;
end



end
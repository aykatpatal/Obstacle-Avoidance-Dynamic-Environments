function next_heading=find_heading(manu,next_manu)

if (strcmp(manu,'top') && strcmp(next_manu,'top'))||(strcmp(manu,'top') && strcmp(next_manu,'right'))||(strcmp(manu,'top') && strcmp(next_manu,'left'))||(strcmp(manu,'topright') && strcmp(next_manu,'left'))||(strcmp(manu,'topright') && strcmp(next_manu,'top'))||(strcmp(manu,'topleft') && strcmp(next_manu,'top'))||(strcmp(manu,'topleft') && strcmp(next_manu,'right'))
    next_heading=pi/2;
elseif(strcmp(manu,'bottom') && strcmp(next_manu,'left'))||(strcmp(manu,'bottom') && strcmp(next_manu,'right'))||(strcmp(manu,'bottom') && strcmp(next_manu,'bottom'))||(strcmp(manu,'bottomright') && strcmp(next_manu,'bottom'))||(strcmp(manu,'bottomright') && strcmp(next_manu,'left'))||(strcmp(manu,'bottomleft') && strcmp(next_manu,'bottom'))||(strcmp(manu,'bottomleft') && strcmp(next_manu,'left'))||(strcmp(manu,'bottomleft') && strcmp(next_manu,'right'))
    next_heading=3*pi/2;
elseif(strcmp(manu,'right') && strcmp(next_manu,'right'))||(strcmp(manu,'right') && strcmp(next_manu,'top'))||(strcmp(manu,'right') && strcmp(next_manu,'bottom'))||(strcmp(manu,'topright') && strcmp(next_manu,'bottom'))||(strcmp(manu,'bottomright') && strcmp(next_manu,'top'))||(strcmp(manu,'bottomright') && strcmp(next_manu,'right'))||(strcmp(manu,'topright') && strcmp(next_manu,'right'))
    next_heading=0;
elseif(strcmp(manu,'left') && strcmp(next_manu,'left'))||(strcmp(manu,'left') && strcmp(next_manu,'top'))||(strcmp(manu,'left') && strcmp(next_manu,'bottom'))||(strcmp(manu,'bottomleft') && strcmp(next_manu,'top'))||(strcmp(manu,'topleft') && strcmp(next_manu,'bottom'))||(strcmp(manu,'topleft') && strcmp(next_manu,'left'))
    next_heading=pi;
end


end
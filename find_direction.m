function [manu, next_manu]=find_direction(x,y,x1,y1,x2,y2)


    if (x==x1 && y<y1)&&(x2==x1 && y2>y1)
                manu='top';
                next_manu='top';
    elseif ((x==x1 && y<y1)&&(x2>x1 && y2>=y1))
                manu='top';
                next_manu='right';
    elseif ((x==x1 && y<y1)&&(x2<x1 && y2>=y1))
                manu='top';
                next_manu='left';
    elseif ((x==x1 && y>y1)&&(x2<x1 && y2<=y1))
                manu='bottom';
                next_manu='left';
    elseif ((x==x1 && y>y1)&&(x2>x1 && y2<=y1))
                manu='bottom';
                next_manu='right';
    elseif ((x==x1 && y>y1)&&(x2==x1 && y2<=y1))
                manu='bottom';
                next_manu='bottom';
    elseif ((x1>x && y==y1)&&(x2>x1 && y2==y1))
                manu='right';
                next_manu='right';
    elseif ((x1>x && y==y1)&&(x2>x1 && y2>y1))
                manu='right';
                next_manu='top';
    elseif ((x1>x && y==y1)&&(x2>x1 && y2<y1))
                manu='right';
                next_manu='bottom';
    elseif ((x1<x && y==y1)&&(x2<x1 && y2==y1))
                manu='left';
                next_manu='left';
    elseif ((x1<x && y==y1)&&(x2<x1 && y2<y1))
                manu='left';
                next_manu='bottom';
    elseif ((x1<x && y==y1)&&(x2<x1 && y2>y1))
                manu='left';
                next_manu='top';
                
    elseif ((x1>x && y1>y)&&(x2<x1 && y2>y1))
                manu='topright';
                next_manu='left';
   elseif ((x1>x && y1>y)&&(x2==x1 && y2>y1))
                manu='topright';
                next_manu='top';             
   elseif ((x1>x && y1>y)&&(x2>x1 && y2>=y1))
                manu='topright';
                next_manu='right';
   elseif ((x1>x && y1>y)&&(x2>x1 && y2<y1))
                manu='topright';
                next_manu='bottom';
   
   elseif ((x1>x && y1<y)&&(x2==x1 && y2<y1))
                manu='bottomright';
                next_manu='bottom';
   elseif ((x1>x && y1<y)&&(x2<x1 && y2<y1))
                manu='bottomright';
                next_manu='left';
   elseif ((x1>x && y1<y)&&(x2>x1 && y2<=y1))
                manu='bottomright';
                next_manu='right';
   elseif ((x1>x && y1<y)&&(x2>x1 && y2>y1))
                manu='bottomright';
                next_manu='top';
                
   elseif ((x1<x && y1<y)&&(x2==x1 && y2<y1))
                manu='bottomleft';
                next_manu='bottom';
   elseif ((x1<x && y1<y)&&(x2>x1 && y2<y1))
                manu='bottomleft';
                next_manu='right';             
   elseif ((x1<x && y1<y)&&(x2<x1 && y2<=y1))
                manu='bottomleft';
                next_manu='left';
   elseif ((x1<x && y1<y)&&(x2<x1 && y2>y1))
                manu='bottomleft';
                next_manu='top';
                
   elseif ((x1<x && y1>y)&&(x2<x1 && y2<y1))
                manu='topleft';
                next_manu='bottom';
   elseif ((x1<x && y1>y)&&(x2<x1 && y2>=y1))
                manu='topleft';
                next_manu='left';            
   elseif ((x1<x && y1>y)&&(x2==x1 && y2>y1))
                manu='topleft';
                next_manu='top'; 
   elseif ((x1<x && y1>y)&&(x2>x1 && y2>y1))
                manu='topleft';
                next_manu='right';
                    
    end
                
                
end


axis([0 1.5 0 1.5])
A=[0 1 1 0 0];
B=[0 0 1 1 0];

line(A,B);
%hold on
TurnRadius = 0.25;   
PathStep = -1;   
C1=[0 0 0];
C2=[0 0 pi/2];
C3=[0 0 pi];
C4=[0 0 3*pi/2];
%C5=[0 0 2*pi]
for i= 0:1
    for j= 0:1
        for k=0:pi/2:2*pi
            if i==j && i==0
                continue
            end
            D=[i j k];
            path=dubins_curve(C1 ,D, TurnRadius, PathStep);
            hold on
            dubins_curve(C2 ,D, TurnRadius, PathStep);
            hold on
            dubins_curve(C3 ,D, TurnRadius, PathStep);
            hold on
            dubins_curve(C4 ,D, TurnRadius, PathStep);
            hold on
            
        end
    end
end
            


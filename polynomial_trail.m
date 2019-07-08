
clear all;
clc;
syms a0 a1 a2 a3 b0 b1 b2 b3 
tic;disp(toc);
%{
x=a0+a1*t+a2*t^2+a3*t^3;
y=b0+b1*t+b2*t^2+b3*t^3;

x_d=a1+2*a2*t+3*a3*t^2;
y_d=b1+2*b2*t+3*b3*t^2;

v=x_d*cos(theta)+y_d*sin(theta);
x_d*sin(theta)-y_d*cos(theta);
%}

% At t=0, v=0, theta=0

t=5;
v=1;
theta=pi/2;
x=5;
y=10;

eqn1=a0+a1*t+a2*t^2+a3*t^3-x==0;
eqn2=b0+b1*t+b2*t^2+b3*t^3-y==0;
x_d=a1+2*a2*t+3*a3*t^2;
y_d=b1+2*b2*t+3*b3*t^2;
eqn3=x_d*cos(theta)+y_d*sin(theta)-v==0;
eqn4=x_d*sin(theta)-y_d*cos(theta)==0;


% At t=5, v=3, theta=90
t=10;
v=1;
theta=3*pi/2;
x=5;
y=20;

eqn5=a0+a1*t+a2*t^2+a3*t^3-x==0;
eqn6=b0+b1*t+b2*t^2+b3*t^3-y==0;
x_d=a1+2*a2*t+3*a3*t^2;
y_d=b1+2*b2*t+3*b3*t^2;
eqn7=x_d*cos(theta)+y_d*sin(theta)-v==0;
eqn8=x_d*sin(theta)-y_d*cos(theta)==0;





%{
eqn1=a0+5*a1+25*a2+125*a3-3==0;
eqn2=b0+5*b1+25*b2+125*b3-6==0;
eqn3=a1+10*a2+75*a3-2==0;
eqn4=-b1-10*b2-75*b3==0;

eqn5=a0+10*a1+100*a2+1000*a3-10==0;
eqn6=b0+10*b1+100*b2+1000*b3-15==0;
eqn7=b1+10*b2+300*b3-3==0;
eqn8=a1+20*a2+300*a3==0;
%}
[A,B] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4, eqn5, eqn6, eqn7, eqn8], [a0, a1, a2, a3, b0, b1, b2, b3]);

X = linsolve(A,B);

PATH_IDX=1;
for t=5:0.1:10
    %disp('hello');
    x=X(1)+X(2)*t+X(3)*t^2+X(4)*t^3;
    y=X(5)+X(6)*t+X(7)*t^2+X(8)*t^3;
    x_d=X(2)+2*X(3)*t+3*X(4)*t^2;
    y_d=X(6)+2*X(7)*t+3*X(8)*t^2;
    
    th=(atan2(y_d,x_d));
    path(PATH_IDX,1)=round(double(x),3);
    path(PATH_IDX,2)=round(double(y),3);
    path(PATH_IDX,3)=round(double(th),3);
    PATH_IDX=PATH_IDX+1;
    plot(x,y,'bo');
    hold on
    
end
disp(toc);
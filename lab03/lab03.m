% Ћабораторна€ работа є3
clear
clc
close all
rho0 = 1.204;
g = 9.81;
r = 0.11;
m = 0.45;
Cd = 0.5;
kk = 0.6;
v0 = 35;
alpha = 40*pi/180;
beta = 27*pi/180;
adec = 0.05;
s0 = [0;0;0;v0*cos(alpha)*cos(beta);v0*cos(alpha)*sin(beta);v0*sin(alpha)];
[t,s] = ode45(@(tt,ss) rhs3(tt,ss,rho0,r,m,Cd,kk,adec,g),0:0.01:5,s0);
x = s(:,1);
y = s(:,2);
z = s(:,3);
vx = s(:,4);
vy = s(:,5);
vz = s(:,6);
v = sqrt(vx.^2+vy.^2+vz.^2);
ihit = min(find(z<0));
if isempty(ihit)
    iend = length(z);
else
    iend = max(1,ihit-1);
end
x = x(1:iend);
y = y(1:iend);
z = z(1:iend);
v = v(1:iend);
t = t(1:iend);
figure
subplot(1,2,1)
plot3(x,y,z,'LineWidth',1.5)
hold on
plot3(x,y,zeros(size(x)),'k:')
plot3(x(1),y(1),z(1),'gs','MarkerSize',9,'MarkerFaceColor','g')
plot3(x(end),y(end),0,'rs','MarkerSize',9,'MarkerFaceColor','r')
grid on
xlabel('x, м')
ylabel('y, м')
zlabel('z, м')
title('“раектори€ полета м€ча')
view(3)
subplot(1,2,2)
plot(t,v,'LineWidth',1.5)
grid on
xlabel('t, с')
ylabel('v, м/с')
title('—корость м€ча')
figure
hold on
grid on
plot3(x,y,zeros(size(x)),'k:')
hb = plot3(x(1),y(1),z(1),'o','MarkerSize',14,'MarkerFaceColor',[1 0.55 0.1],'MarkerEdgeColor','k');
ht = plot3(x(1),y(1),z(1),'b-','LineWidth',1.5);
xlabel('x, м')
ylabel('y, м')
zlabel('z, м')
title('јнимаци€ полета вращающегос€ м€ча')
n = length(x);
for j = 1:3:n
    set(hb,'XData',x(j),'YData',y(j),'ZData',z(j))
    set(ht,'XData',x(1:j),'YData',y(1:j),'ZData',z(1:j))
    view(35+40*sin(j/40),20+15*cos(j/55))
    drawnow
end

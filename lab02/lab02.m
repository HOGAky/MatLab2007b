% Лабораторная работа №2
clear
clc
close all
r = 0.025;
rho = 1.19e3;
Cd = 0.5;
rho0 = 1.204;
g = 9.81;
alpha = 45*pi/180;
v0 = 30;
m = rho*4*pi*r^3/3;
S = pi*r^2;
s0 = [0;0;v0*cos(alpha);v0*sin(alpha)];
[t,s] = ode45(@(tt,ss) rhs2(tt,ss,m,S,Cd,rho0,g),0:0.01:8,s0);
x = s(:,1);
y = s(:,2);
vx = s(:,3);
vy = s(:,4);
v = sqrt(vx.^2+vy.^2);
iend = max(find(y>=0));
if iend < length(y)
    f = y(iend)/(y(iend)-y(iend+1));
    x = [x(1:iend);x(iend)+f*(x(iend+1)-x(iend))];
    v = [v(1:iend);v(iend)+f*(v(iend+1)-v(iend))];
    t = [t(1:iend);t(iend)+f*(t(iend+1)-t(iend))];
    y = [y(1:iend);0];
end
xm = 1.05*max(x);
ym = 1.25*max(y);
figure
subplot(1,2,1)
plot(x,y,'LineWidth',1.5)
grid on
axis equal
axis([0 xm 0 ym])
xlabel('x, м')
ylabel('y, м')
title('Траектория мяча')
subplot(1,2,2)
plot(t,v,'LineWidth',1.5)
grid on
xlabel('t, с')
ylabel('v, м/с')
title('Скорость мяча')
rb = 0.015*xm;
th = linspace(0,2*pi,40);
figure
hold on
grid on
fill([0 xm xm 0],[-0.06*ym -0.06*ym 0 0],[0.6 0.8 0.5],'EdgeColor','none')
plot([0 xm],[0 0],'k-','LineWidth',2)
plot(x,y+rb,'k:')
h = fill(x(1)+rb*cos(th),y(1)+rb+rb*sin(th),'r');
axis equal
axis([0 xm -0.06*ym ym+2*rb])
xlabel('x, м')
ylabel('y, м')
title('Анимация полета мяча')
n = length(x);
for k = unique([1:4:n n])
    set(h,'XData',x(k)+rb*cos(th),'YData',y(k)+rb+rb*sin(th))
    drawnow
end
Cds = [1.11 1.33 0.55 0.045 0.1];
names = {'Диск (Cd=1.11)','Полусфера (Cd=1.33)','Полусфера (Cd=0.55)','Каплевидное тело (Cd=0.045)','Каплевидное тело (Cd=0.1)'};
figure
hold on
grid on
xmax = 0;
ymax = 0;
for j = 1:5
    [tj,sj] = ode45(@(tt,ss) rhs2(tt,ss,m,S,Cds(j),rho0,g),0:0.01:8,s0);
    yj = sj(:,2);
    xj = sj(:,1);
    ij = max(find(yj>=0));
    if ij < length(yj)
        f = yj(ij)/(yj(ij)-yj(ij+1));
        xj = [xj(1:ij);xj(ij)+f*(xj(ij+1)-xj(ij))];
        yj = [yj(1:ij);0];
    end
    plot(xj,yj,'LineWidth',1.4)
    xmax = max(xmax,max(xj));
    ymax = max(ymax,max(yj));
end
axis equal
axis([0 1.05*xmax 0 1.25*ymax])
xlabel('x, м')
ylabel('y, м')
title('Траектории тел различной формы')
legend(names,'Location','best')

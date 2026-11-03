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
[t,s] = ode45('rhs2',[0 8],s0,[],m,S,Cd,rho0,g);
x = s(:,1);
y = s(:,2);
vx = s(:,3);
vy = s(:,4);
v = sqrt(vx.^2+vy.^2);
iend = max(find(y>=0));
if isempty(iend)
    iend = length(y);
end
x = x(1:iend);
y = y(1:iend);
v = v(1:iend);
t = t(1:iend);
figure
subplot(1,2,1)
plot(x,y,'LineWidth',1.5)
grid on
axis equal
xlabel('x, м')
ylabel('y, м')
title('Траектория мяча')
subplot(1,2,2)
plot(t,v,'LineWidth',1.5)
grid on
xlabel('t, с')
ylabel('v, м/с')
title('Скорость мяча')
figure
hold on
grid on
axis equal
plot(x,y,'k:')
h = plot(x(1),y(1),'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k');
xlabel('x, м')
ylabel('y, м')
title('Анимация полета мяча')
ylim([0 1.15*max(y)])
for k = 1:4:length(x)
    set(h,'XData',x(k),'YData',y(k))
    drawnow
end
Cds = [1.11 1.33 0.55 0.045 0.1];
names = {'Диск (Cd=1.11)','Полусфера (Cd=1.33)','Полусфера (Cd=0.55)','Каплевидное тело (Cd=0.045)','Каплевидное тело (Cd=0.1)'};
figure
hold on
grid on
axis equal
for j = 1:5
    [tj,sj] = ode45('rhs2',[0 8],s0,[],m,S,Cds(j),rho0,g);
    yj = sj(:,2);
    xj = sj(:,1);
    ij = max(find(yj>=0));
    if isempty(ij)
        ij = length(yj);
    end
    plot(xj(1:ij),yj(1:ij),'LineWidth',1.4)
end
xlabel('x, м')
ylabel('y, м')
title('Траектории тел различной формы')
legend(names,'Location','best')

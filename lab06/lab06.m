% Лабораторная работа №6
clear
clc
close all
g = 9.81;
m = 2;
b = 0.3;
c = 0.2;
l = 0.5;
phi0 = 35*pi/180;
w0 = 0;
J = m*(b^2+c^2)/12+m*l^2;
T = 2*pi*sqrt(J/(m*g*l));
[t,s] = ode45(@(tt,ss) pend_rhs(tt,ss,m,g,l,J),0:0.01:4*T,[phi0;w0]);
phi = s(:,1);
w = s(:,2);
figure
subplot(2,1,1)
plot(t,w,'LineWidth',1.4)
grid on
xlabel('t, с')
ylabel('\omega, рад/с')
title('Угловая скорость маятника')
subplot(2,1,2)
plot(t,phi,'LineWidth',1.4)
grid on
xlabel('t, с')
ylabel('\phi, рад')
title('Угол отклонения центра масс')
figure
plot(phi,w,'LineWidth',1.4)
grid on
xlabel('\phi, рад')
ylabel('\omega, рад/с')
title('Фазовая траектория центра масс')
figure
axis equal
hold on
grid on
R = l+sqrt(b^2+c^2)/2;
xlim([-1.3*R 1.3*R])
ylim([-1.3*R 0.4*R])
xlabel('x, м')
ylabel('y, м')
title('Свободные колебания физического маятника')
plot(0,0,'k+','MarkerSize',12,'LineWidth',2)
xc = l*sin(phi(1));
yc = -l*cos(phi(1));
[px,py] = rectpts(xc,yc,b,c,phi(1));
hr = fill(px,py,[0.75 0.5 0.3]);
hrod = plot([0 xc],[0 yc],'k-','LineWidth',2);
for k = 1:4:length(t)
    xc = l*sin(phi(k));
    yc = -l*cos(phi(k));
    [px,py] = rectpts(xc,yc,b,c,phi(k));
    set(hr,'XData',px,'YData',py)
    set(hrod,'XData',[0 xc],'YData',[0 yc])
    drawnow
    pause(0.04)
end

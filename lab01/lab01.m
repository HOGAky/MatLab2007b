% Лабораторная работа №1
clear
clc
close all
r = 5.3e-4;
rho = 13.55e3;
rho0 = 1.26e3;
mu = 1.48;
g = 9.81;
[t,Y] = ode45('rhs1',[0 0.05],[0;0],[],r,rho,rho0,mu,g);
v = Y(:,1);
y = Y(:,2);
figure
plot(t,v,'LineWidth',1.5)
grid on
xlabel('t, с')
ylabel('v, м/с')
title('Скорость ртутного шарика в глицерине')
figure
plot(t,y,'LineWidth',1.5)
grid on
xlabel('t, с')
ylabel('y, м')
title('Координата ртутного шарика')
figure
axis equal
hold on
grid on
xlim([-1e-3 1e-3])
ylim([-1.1*max(y)-1e-4 1e-4])
xlabel('x, м')
ylabel('y, м')
title('Падение ртутного шарика в глицерине')
hb = plot(0,0,'o','MarkerSize',12,'MarkerFaceColor',[0.6 0.6 0.7],'MarkerEdgeColor','k');
ht = plot(0,0,'-','Color',[0.4 0.4 0.8]);
for k = 1:length(t)
    set(hb,'XData',0,'YData',-y(k))
    set(ht,'XData',zeros(1,k),'YData',-y(1:k))
    drawnow
end
r = 1e-3;
rho = 7.8e3;
rho0 = 1e3;
mu = 1e-3;
[t,Y] = ode45('rhs1',[0 8],[0;0],[],r,rho,rho0,mu,g);
v = Y(:,1);
y = Y(:,2);
figure
plot(t,v,'LineWidth',1.5)
grid on
xlabel('t, с')
ylabel('v, м/с')
title('Скорость стального шарика в воде')
figure
plot(t,y,'LineWidth',1.5)
grid on
xlabel('t, с')
ylabel('y, м')
title('Координата стального шарика')
figure
axis equal
hold on
grid on
xlim([-2 2])
ylim([-1.1*max(y)-0.5 0.5])
xlabel('x, м')
ylabel('y, м')
title('Падение стального шарика в воде')
hb = plot(0,0,'o','MarkerSize',12,'MarkerFaceColor',[0.2 0.4 0.8],'MarkerEdgeColor','k');
for k = 1:4:length(t)
    set(hb,'XData',0,'YData',-y(k))
    drawnow
end

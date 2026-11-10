% Лабораторная работа №4
clear
clc
close all
opts = odeset('RelTol',1e-8,'AbsTol',1e-6);
G = 6.67e-11;
M = 1.989e30;
mu = G*M;
aM = 57.91e9;
eM = 0.206;
qM = aM*(1-eM);
TM = 7.6e6;
aV = 108.21e9;
eV = 0.0068;
qV = aV*(1-eV);
dt = 0.001*TM;
tspan = 0:dt:0.9*TM;
vP = sqrt(mu*(1+eM)/(aM*(1-eM)));
[t,s] = ode45(@(tt,ss) kepler_rhs(tt,ss,mu),tspan,[qM;0;0;vP],opts);
x = s(:,1);
y = s(:,2);
n = length(x);
c = aM*eM;
figure
hold on
grid on
axis equal
plot(x,y,'b-','LineWidth',1.2)
plot(0,0,'o','MarkerSize',11,'MarkerFaceColor',[1 0.8 0],'MarkerEdgeColor','k')
plot(-2*c,0,'x','MarkerSize',11,'LineWidth',2,'Color','r')
plot(x(1),y(1),'s','MarkerSize',8,'MarkerFaceColor','g')
plot(x(n),y(n),'s','MarkerSize',8,'MarkerFaceColor','r')
ids = round(linspace(1,n,8));
ids = ids(3:5);
for j = 1:3
    plot([0 x(ids(j))],[0 y(ids(j))],'r--')
    plot([-2*c x(ids(j))],[0 y(ids(j))],'g--')
    plot(x(ids(j)),y(ids(j)),'o','MarkerSize',7,'MarkerFaceColor',[0.2 0.6 1],'MarkerEdgeColor','k')
    r1 = sqrt(x(ids(j))^2+y(ids(j))^2);
    r2 = sqrt((x(ids(j))+2*c)^2+y(ids(j))^2);
    fprintf('Первый закон, точка %d: r1+r2 = %.6e м, 2a = %.6e м\n',j,r1+r2,2*aM)
end
xlabel('x, м')
ylabel('y, м')
title('Проверка первого закона Кеплера')
figure
hold on
grid on
axis equal
plot(x,y,'b-','LineWidth',1.2)
plot(0,0,'o','MarkerSize',11,'MarkerFaceColor',[1 0.8 0],'MarkerEdgeColor','k')
plot(x(1),y(1),'s','MarkerSize',8,'MarkerFaceColor','g')
plot(x(n),y(n),'s','MarkerSize',8,'MarkerFaceColor','r')
cols = [0.9 0.4 0.4;0.4 0.8 0.4;0.4 0.4 0.9];
starts = [80 400 750];
for j = 1:3
    i1 = starts(j);
    i2 = i1+round(0.1*TM/dt);
    xs = [0;x(i1:i2)];
    ys = [0;y(i1:i2)];
    fill(xs,ys,cols(j,:),'FaceAlpha',0.35,'EdgeColor',cols(j,:))
    S = polyarea(xs,ys);
    fprintf('Второй закон, сектор %d: площадь = %.6e м^2\n',j,S)
end
xlabel('x, м')
ylabel('y, м')
title('Проверка второго закона Кеплера')
TV = 2*pi*sqrt(aV^3/mu);
dtv = TV/1000;
vPV = sqrt(mu*(1+eV)/(aV*(1-eV)));
[tv,sv] = ode45(@(tt,ss) kepler_rhs(tt,ss,mu),0:dtv:TV,[qV;0;0;vPV],opts);
[tm,sm] = ode45(@(tt,ss) kepler_rhs(tt,ss,mu),0:dtv:TV,[qM;0;0;vP],opts);
ic = find(sm(1:end-1,2)<0 & sm(2:end,2)>=0 & sm(1:end-1,1)>0);
ic = ic(1);
TMnum = tm(ic)-sm(ic,2)*(tm(ic+1)-tm(ic))/(sm(ic+1,2)-sm(ic,2));
fprintf('Третий закон: TM = %.6e с, TV = %.6e с\n',TMnum,TV)
fprintf('TM^2/aM^3 = %.6e с^2/м^3\n',TMnum^2/aM^3)
fprintf('TV^2/aV^3 = %.6e с^2/м^3\n',TV^2/aV^3)
fprintf('TM^2/TV^2 = %.6f, aM^3/aV^3 = %.6f\n',TMnum^2/TV^2,aM^3/aV^3)
figure
hold on
grid on
axis equal
plot(sm(:,1),sm(:,2),'-','Color',[0.5 0.5 0.7])
plot(sv(:,1),sv(:,2),'-','Color',[0.85 0.6 0.2])
plot(0,0,'o','MarkerSize',13,'MarkerFaceColor',[1 0.8 0],'MarkerEdgeColor','k')
plot(sm(1,1),sm(1,2),'s','MarkerSize',8,'MarkerFaceColor','g')
plot(sv(1,1),sv(1,2),'s','MarkerSize',8,'MarkerFaceColor','g')
hM = plot(sm(1,1),sm(1,2),'o','MarkerSize',8,'MarkerFaceColor',[0.5 0.5 0.6],'MarkerEdgeColor','k');
hV = plot(sv(1,1),sv(1,2),'o','MarkerSize',10,'MarkerFaceColor',[1 0.9 0.4],'MarkerEdgeColor','k');
xlabel('x, м')
ylabel('y, м')
title('Проверка третьего закона Кеплера')
for k = 1:4:length(tm)
    set(hM,'XData',sm(k,1),'YData',sm(k,2))
    set(hV,'XData',sv(k,1),'YData',sv(k,2))
    drawnow
    pause(0.04)
end
plot(sm(end,1),sm(end,2),'s','MarkerSize',8,'MarkerFaceColor','r')
plot(sv(end,1),sv(end,2),'s','MarkerSize',8,'MarkerFaceColor','r')

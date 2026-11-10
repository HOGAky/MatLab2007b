% Лабораторная работа №12
clear
clc
close all
labdir = fileparts(mfilename('fullpath'));
if ~isempty(labdir)
    cd(labdir)
end
k = 9e9;
Q1 = 2e-6;
Q2 = 2e-6;
X1 = -0.6;
Y1 = 0;
X2 = 0.6;
Y2 = 0;
q3 = -3e-8;
q4 = -3e-8;
m3 = 1e-4;
m4 = 1e-4;
v03 = 3;
v04 = 3;
al3 = 180*pi/180;
al4 = 0;
s0 = [0;1.2;v03*cos(al3);v03*sin(al3);0;-1.2;v04*cos(al4);v04*sin(al4)];
[t,s] = ode45(@(tt,ss) charges_rhs(tt,ss,k,Q1,Q2,X1,Y1,X2,Y2,q3,q4,m3,m4),0:0.01:8,s0);
x3 = s(:,1);
y3 = s(:,2);
x4 = s(:,5);
y4 = s(:,6);
v3 = sqrt(s(:,3).^2+s(:,4).^2);
v4 = sqrt(s(:,7).^2+s(:,8).^2);
figure
hold on
grid on
axis equal
plot(X1,Y1,'o','MarkerSize',13,'MarkerFaceColor','r','MarkerEdgeColor','k')
plot(X2,Y2,'o','MarkerSize',13,'MarkerFaceColor','b','MarkerEdgeColor','k')
h3 = plot(x3(1),y3(1),'o','MarkerSize',9,'MarkerFaceColor',[1 0.6 0.2],'MarkerEdgeColor','k');
h4 = plot(x4(1),y4(1),'o','MarkerSize',9,'MarkerFaceColor',[0.3 0.8 0.4],'MarkerEdgeColor','k');
t3 = plot(x3(1),y3(1),'-','Color',[0.8 0.4 0]);
t4 = plot(x4(1),y4(1),'-','Color',[0 0.6 0.2]);
xlabel('x, м')
ylabel('y, м')
title('Движение заряженных частиц в поле двух зарядов')
lim = 1.15*max(abs([x3;y3;x4;y4;X1;X2]));
axis([-lim lim -lim lim])
for n = unique([1:3:length(t) length(t)])
    set(h3,'XData',x3(n),'YData',y3(n))
    set(h4,'XData',x4(n),'YData',y4(n))
    set(t3,'XData',x3(1:n),'YData',y3(1:n))
    set(t4,'XData',x4(1:n),'YData',y4(1:n))
    drawnow
end
figure
plot(t,v3,'LineWidth',1.2)
hold on
plot(t,v4,'LineWidth',1.2)
grid on
xlabel('t, с')
ylabel('v, м/с')
title('Скорости движущихся частиц')
legend('Частица 3','Частица 4','Location','best')

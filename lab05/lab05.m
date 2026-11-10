% Лабораторная работа №5
clear
clc
close all
labdir = fileparts(mfilename('fullpath'));
if ~isempty(labdir)
    cd(labdir)
end
opts = odeset('RelTol',1e-8,'AbsTol',1e-6);
G = 6.67e-11;
Ms = 1.989e30;
m = [Ms;Ms;Ms];
R = 0.5e12;
v0 = 15e3;
T = 6.4e8;
dt = 6.4e5;
ang = [90 210 330]*pi/180;
x0 = R*cos(ang);
y0 = R*sin(ang);
al = [180 300 60]*pi/180;
vx0 = v0*cos(al);
vy0 = v0*sin(al);
s0 = [x0(:);y0(:);vx0(:);vy0(:)];
[t,S] = ode45(@(tt,ss) nbody_rhs(tt,ss,m,G),0:dt:T,s0,opts);
lim = 1.15*max(max(abs(S(:,1:6))));
figure
hold on
grid on
axis equal
xlim([-lim lim])
ylim([-lim lim])
plot(S(1,1),S(1,4),'s','MarkerSize',8,'MarkerFaceColor','g')
plot(S(1,2),S(1,5),'s','MarkerSize',8,'MarkerFaceColor','g')
plot(S(1,3),S(1,6),'s','MarkerSize',8,'MarkerFaceColor','g')
h1 = plot(S(1,1),S(1,4),'o','MarkerSize',9,'MarkerFaceColor',[1 0.7 0.1],'MarkerEdgeColor','k');
h2 = plot(S(1,2),S(1,5),'o','MarkerSize',9,'MarkerFaceColor',[0.3 0.7 1],'MarkerEdgeColor','k');
h3 = plot(S(1,3),S(1,6),'o','MarkerSize',9,'MarkerFaceColor',[1 0.4 0.4],'MarkerEdgeColor','k');
t1 = plot(S(1,1),S(1,4),'-','Color',[0.7 0.5 0]);
t2 = plot(S(1,2),S(1,5),'-','Color',[0 0.4 0.7]);
t3 = plot(S(1,3),S(1,6),'-','Color',[0.7 0 0]);
xlabel('x, м')
ylabel('y, м')
title('Движение компонент тройной звезды')
for k = 1:4:length(t)
    set(h1,'XData',S(k,1),'YData',S(k,4))
    set(h2,'XData',S(k,2),'YData',S(k,5))
    set(h3,'XData',S(k,3),'YData',S(k,6))
    set(t1,'XData',S(1:k,1),'YData',S(1:k,4))
    set(t2,'XData',S(1:k,2),'YData',S(1:k,5))
    set(t3,'XData',S(1:k,3),'YData',S(1:k,6))
    drawnow
end
m = [0.9*Ms;0.9*Ms;3e20];
d = 0.83e11;
x0 = [0 0 -2e11];
y0 = [-d d 0];
vv = [19e3 19e3 40e3];
al = [0 180 80]*pi/180;
vx0 = vv.*cos(al);
vy0 = vv.*sin(al);
s0 = [x0(:);y0(:);vx0(:);vy0(:)];
[t,S] = ode45(@(tt,ss) nbody_rhs(tt,ss,m,G),0:1e5:2e8,s0,opts);
lim = 1.15*max(max(abs(S(:,1:6))));
figure
hold on
grid on
axis equal
xlim([-lim lim])
ylim([-lim lim])
plot(S(1,1),S(1,4),'s','MarkerSize',8,'MarkerFaceColor','g')
plot(S(1,2),S(1,5),'s','MarkerSize',8,'MarkerFaceColor','g')
plot(S(1,3),S(1,6),'s','MarkerSize',8,'MarkerFaceColor','g')
h1 = plot(S(1,1),S(1,4),'o','MarkerSize',10,'MarkerFaceColor',[1 0.8 0.1],'MarkerEdgeColor','k');
h2 = plot(S(1,2),S(1,5),'o','MarkerSize',10,'MarkerFaceColor',[1 0.6 0.2],'MarkerEdgeColor','k');
h3 = plot(S(1,3),S(1,6),'o','MarkerSize',7,'MarkerFaceColor',[0.6 0.6 0.6],'MarkerEdgeColor','k');
t1 = plot(S(1,1),S(1,4),'-','Color',[0.7 0.5 0]);
t2 = plot(S(1,2),S(1,5),'-','Color',[0.7 0.3 0]);
t3 = plot(S(1,3),S(1,6),'-','Color',[0.3 0.3 0.3]);
xlabel('x, м')
ylabel('y, м')
title('Астероид в гравитационном поле двойной звезды')
for k = 1:4:length(t)
    set(h1,'XData',S(k,1),'YData',S(k,4))
    set(h2,'XData',S(k,2),'YData',S(k,5))
    set(h3,'XData',S(k,3),'YData',S(k,6))
    set(t1,'XData',S(1:k,1),'YData',S(1:k,4))
    set(t2,'XData',S(1:k,2),'YData',S(1:k,5))
    set(t3,'XData',S(1:k,3),'YData',S(1:k,6))
    drawnow
end
Me = 5.974e24;
Mm = 7.35e22;
am = 3.844e8;
em = 0.0549;
qm = 3.633e8;
as = 1.2e8;
qs = 4.2164e7;
es = 1-qs/as;
vM = sqrt(G*Me*(1+em)/(am*(1-em)));
vS = sqrt(G*Me*(1+es)/(as*(1-es)));
Ts = 2.36e6;
dts = 2.36e3;
s0 = [qm;0;qs;0;0;vM;0;vS];
[t,S0] = ode45(@(tt,ss) ems_rhs(tt,ss,G,Me,Mm,0),0:dts:Ts,s0,opts);
[t,S1] = ode45(@(tt,ss) ems_rhs(tt,ss,G,Me,Mm,1),0:dts:Ts,s0,opts);
lim = 1.15*qm;
figure
subplot(1,2,1)
hold on
grid on
axis equal
xlim([-lim lim])
ylim([-lim lim])
plot(0,0,'o','MarkerSize',12,'MarkerFaceColor',[0.2 0.5 1],'MarkerEdgeColor','k')
a0 = plot(S0(1,1),S0(1,2),'o','MarkerSize',8,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerEdgeColor','k');
b0 = plot(S0(1,3),S0(1,4),'o','MarkerSize',6,'MarkerFaceColor',[1 0.3 0.3],'MarkerEdgeColor','k');
c0 = plot(S0(1,3),S0(1,4),'-','Color',[0.8 0.2 0.2]);
d0 = plot(S0(1,1),S0(1,2),':','Color',[0.5 0.5 0.5]);
xlabel('x, м')
ylabel('y, м')
title('Без учета возмущения Луны')
subplot(1,2,2)
hold on
grid on
axis equal
xlim([-lim lim])
ylim([-lim lim])
plot(0,0,'o','MarkerSize',12,'MarkerFaceColor',[0.2 0.5 1],'MarkerEdgeColor','k')
a1 = plot(S1(1,1),S1(1,2),'o','MarkerSize',8,'MarkerFaceColor',[0.8 0.8 0.8],'MarkerEdgeColor','k');
b1 = plot(S1(1,3),S1(1,4),'o','MarkerSize',6,'MarkerFaceColor',[1 0.3 0.3],'MarkerEdgeColor','k');
c1 = plot(S1(1,3),S1(1,4),'-','Color',[0.8 0.2 0.2]);
d1 = plot(S1(1,1),S1(1,2),':','Color',[0.5 0.5 0.5]);
xlabel('x, м')
ylabel('y, м')
title('С учетом возмущения Луны')
for k = 1:3:length(t)
    set(a0,'XData',S0(k,1),'YData',S0(k,2))
    set(b0,'XData',S0(k,3),'YData',S0(k,4))
    set(c0,'XData',S0(1:k,3),'YData',S0(1:k,4))
    set(d0,'XData',S0(1:k,1),'YData',S0(1:k,2))
    set(a1,'XData',S1(k,1),'YData',S1(k,2))
    set(b1,'XData',S1(k,3),'YData',S1(k,4))
    set(c1,'XData',S1(1:k,3),'YData',S1(1:k,4))
    set(d1,'XData',S1(1:k,1),'YData',S1(1:k,2))
    drawnow
end

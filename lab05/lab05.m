clear
clc
close all
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
[ta,Sa] = ode45(@(tt,ss) nbody_rhs(tt,ss,m,G),0:dt:T,s0,opts);
lim = 1.15*max(max(abs(Sa(:,1:6))));
fig1 = figure;
hold on
grid on
axis equal
xlim([-lim lim])
ylim([-lim lim])
plot(Sa(1,1),Sa(1,4),'s','MarkerSize',8,'MarkerFaceColor','g')
plot(Sa(1,2),Sa(1,5),'s','MarkerSize',8,'MarkerFaceColor','g')
plot(Sa(1,3),Sa(1,6),'s','MarkerSize',8,'MarkerFaceColor','g')
h1 = plot(Sa(1,1),Sa(1,4),'o','MarkerSize',9,'MarkerFaceColor',[1 0.7 0.1],'MarkerEdgeColor','k');
h2 = plot(Sa(1,2),Sa(1,5),'o','MarkerSize',9,'MarkerFaceColor',[0.3 0.7 1],'MarkerEdgeColor','k');
h3 = plot(Sa(1,3),Sa(1,6),'o','MarkerSize',9,'MarkerFaceColor',[1 0.4 0.4],'MarkerEdgeColor','k');
t1 = plot(Sa(1,1),Sa(1,4),'-','Color',[0.7 0.5 0]);
t2 = plot(Sa(1,2),Sa(1,5),'-','Color',[0 0.4 0.7]);
t3 = plot(Sa(1,3),Sa(1,6),'-','Color',[0.7 0 0]);
xlabel('x, м')
ylabel('y, м')
title('Движение компонент тройной звезды')
m = [0.9*Ms;0.9*Ms;3e20];
d = 0.83e11;
x0 = [0 0 -2e11];
y0 = [-d d 0];
vv = [19e3 19e3 40e3];
al = [0 180 80]*pi/180;
vx0 = vv.*cos(al);
vy0 = vv.*sin(al);
s0 = [x0(:);y0(:);vx0(:);vy0(:)];
[tb,Sb] = ode45(@(tt,ss) nbody_rhs(tt,ss,m,G),0:1e5:2e8,s0,opts);
lim = 1.15*max(max(abs(Sb(:,1:6))));
fig2 = figure;
hold on
grid on
axis equal
xlim([-lim lim])
ylim([-lim lim])
plot(Sb(1,1),Sb(1,4),'s','MarkerSize',8,'MarkerFaceColor','g')
plot(Sb(1,2),Sb(1,5),'s','MarkerSize',8,'MarkerFaceColor','g')
plot(Sb(1,3),Sb(1,6),'s','MarkerSize',8,'MarkerFaceColor','g')
h4 = plot(Sb(1,1),Sb(1,4),'o','MarkerSize',10,'MarkerFaceColor',[1 0.8 0.1],'MarkerEdgeColor','k');
h5 = plot(Sb(1,2),Sb(1,5),'o','MarkerSize',10,'MarkerFaceColor',[1 0.6 0.2],'MarkerEdgeColor','k');
h6 = plot(Sb(1,3),Sb(1,6),'o','MarkerSize',7,'MarkerFaceColor',[0.6 0.6 0.6],'MarkerEdgeColor','k');
t4 = plot(Sb(1,1),Sb(1,4),'-','Color',[0.7 0.5 0]);
t5 = plot(Sb(1,2),Sb(1,5),'-','Color',[0.7 0.3 0]);
t6 = plot(Sb(1,3),Sb(1,6),'-','Color',[0.3 0.3 0.3]);
xlabel('x, м')
ylabel('y, м')
title('Астероид в гравитационном поле двойной звезды')
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
[tc,S0] = ode45(@(tt,ss) ems_rhs(tt,ss,G,Me,Mm,0),0:dts:Ts,s0,opts);
[tc,S1] = ode45(@(tt,ss) ems_rhs(tt,ss,G,Me,Mm,1),0:dts:Ts,s0,opts);
lim = 1.15*qm;
fig3 = figure;
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
ka = 1:4:length(ta);
kb = 1:4:length(tb);
kc = 1:3:length(tc);
c = 0;
while ishandle(fig1) || ishandle(fig2) || ishandle(fig3)
    c = c+1;
    if ishandle(fig1)
        k = ka(mod(c-1,length(ka))+1);
        set(h1,'XData',Sa(k,1),'YData',Sa(k,4))
        set(h2,'XData',Sa(k,2),'YData',Sa(k,5))
        set(h3,'XData',Sa(k,3),'YData',Sa(k,6))
        set(t1,'XData',Sa(1:k,1),'YData',Sa(1:k,4))
        set(t2,'XData',Sa(1:k,2),'YData',Sa(1:k,5))
        set(t3,'XData',Sa(1:k,3),'YData',Sa(1:k,6))
    end
    if ishandle(fig2)
        k = kb(mod(c-1,length(kb))+1);
        set(h4,'XData',Sb(k,1),'YData',Sb(k,4))
        set(h5,'XData',Sb(k,2),'YData',Sb(k,5))
        set(h6,'XData',Sb(k,3),'YData',Sb(k,6))
        set(t4,'XData',Sb(1:k,1),'YData',Sb(1:k,4))
        set(t5,'XData',Sb(1:k,2),'YData',Sb(1:k,5))
        set(t6,'XData',Sb(1:k,3),'YData',Sb(1:k,6))
    end
    if ishandle(fig3)
        k = kc(mod(c-1,length(kc))+1);
        set(a0,'XData',S0(k,1),'YData',S0(k,2))
        set(b0,'XData',S0(k,3),'YData',S0(k,4))
        set(c0,'XData',S0(1:k,3),'YData',S0(1:k,4))
        set(d0,'XData',S0(1:k,1),'YData',S0(1:k,2))
        set(a1,'XData',S1(k,1),'YData',S1(k,2))
        set(b1,'XData',S1(k,3),'YData',S1(k,4))
        set(c1,'XData',S1(1:k,3),'YData',S1(1:k,4))
        set(d1,'XData',S1(1:k,1),'YData',S1(1:k,2))
    end
    drawnow
    pause(0.03)
end
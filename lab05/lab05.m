clear
clc
close all
opts = odeset('RelTol',1e-8,'AbsTol',1e-6);
G = 6.67e-11;
Ms = 1.989e30;

% Задание 1. Тройная звезда
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
plot(Sa(:,1),Sa(:,4),'-','Color',[0.8 0.1 0.1],'LineWidth',1.2)
plot(Sa(:,2),Sa(:,5),'-','Color',[0.1 0.3 0.8],'LineWidth',1.2)
plot(Sa(:,3),Sa(:,6),'-','Color',[0.1 0.6 0.1],'LineWidth',1.2)
plot(Sa(end,1),Sa(end,4),'o','MarkerSize',10,'MarkerFaceColor',[1 1 0],'MarkerEdgeColor','k')
plot(Sa(end,2),Sa(end,5),'o','MarkerSize',10,'MarkerFaceColor',[1 1 0],'MarkerEdgeColor','k')
plot(Sa(end,3),Sa(end,6),'o','MarkerSize',10,'MarkerFaceColor',[1 1 0],'MarkerEdgeColor','k')
text(Sa(end,1)+0.04*lim,Sa(end,4)+0.04*lim,'A_n','FontSize',10)
text(Sa(end,2)+0.04*lim,Sa(end,5)+0.04*lim,'B_n','FontSize',10)
text(Sa(end,3)+0.04*lim,Sa(end,6)+0.04*lim,'C_n','FontSize',10)
plot(Sa(1,1),Sa(1,4),'o','MarkerSize',10,'MarkerFaceColor',[1 1 1],'MarkerEdgeColor','k')
plot(Sa(1,2),Sa(1,5),'o','MarkerSize',10,'MarkerFaceColor',[1 1 1],'MarkerEdgeColor','k')
plot(Sa(1,3),Sa(1,6),'o','MarkerSize',10,'MarkerFaceColor',[1 1 1],'MarkerEdgeColor','k')
text(Sa(1,1)+0.04*lim,Sa(1,4)+0.04*lim,'A_0','FontSize',10)
text(Sa(1,2)+0.04*lim,Sa(1,5)+0.04*lim,'B_0','FontSize',10)
text(Sa(1,3)+0.04*lim,Sa(1,6)+0.04*lim,'C_0','FontSize',10)
hA = plot(Sa(1,1),Sa(1,4),'o','MarkerSize',8,'MarkerFaceColor',[0.8 0.1 0.1],'MarkerEdgeColor','k');
hB = plot(Sa(1,2),Sa(1,5),'o','MarkerSize',8,'MarkerFaceColor',[0.1 0.3 0.8],'MarkerEdgeColor','k');
hC = plot(Sa(1,3),Sa(1,6),'o','MarkerSize',8,'MarkerFaceColor',[0.1 0.6 0.1],'MarkerEdgeColor','k');
xlabel('x, м')
ylabel('y, м')
title('Движение компонент тройной звезды')

% Задание 2. Астероид в поле двойной звезды
m = [0.9*Ms;0.9*Ms;3e20];
d = 0.83e11;
x0 = [0 0 -1.5e11];
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
plot(Sb(:,1),Sb(:,4),'-','Color',[0.8 0.1 0.1],'LineWidth',1.2)
plot(Sb(:,2),Sb(:,5),'-','Color',[0.1 0.3 0.8],'LineWidth',1.2)
plot(Sb(:,3),Sb(:,6),'--','Color',[0.1 0.6 0.1],'LineWidth',1.2)
plot(Sb(end,1),Sb(end,4),'o','MarkerSize',10,'MarkerFaceColor',[1 1 0],'MarkerEdgeColor','k')
plot(Sb(end,2),Sb(end,5),'o','MarkerSize',10,'MarkerFaceColor',[1 1 0],'MarkerEdgeColor','k')
plot(Sb(end,3),Sb(end,6),'o','MarkerSize',10,'MarkerFaceColor',[1 0.6 0],'MarkerEdgeColor','k')
text(Sb(end,1)+0.04*lim,Sb(end,4)+0.04*lim,'A_n','FontSize',10)
text(Sb(end,2)+0.04*lim,Sb(end,5)+0.04*lim,'B_n','FontSize',10)
text(Sb(end,3)+0.04*lim,Sb(end,6)+0.04*lim,'C_n','FontSize',10)
plot(Sb(1,1),Sb(1,4),'o','MarkerSize',10,'MarkerFaceColor',[1 1 1],'MarkerEdgeColor','k')
plot(Sb(1,2),Sb(1,5),'o','MarkerSize',10,'MarkerFaceColor',[1 1 1],'MarkerEdgeColor','k')
plot(Sb(1,3),Sb(1,6),'o','MarkerSize',10,'MarkerFaceColor',[1 1 1],'MarkerEdgeColor','k')
text(Sb(1,1)+0.04*lim,Sb(1,4)+0.04*lim,'A_0','FontSize',10)
text(Sb(1,2)+0.04*lim,Sb(1,5)+0.04*lim,'B_0','FontSize',10)
text(Sb(1,3)+0.04*lim,Sb(1,6)+0.04*lim,'C_0','FontSize',10)
hD = plot(Sb(1,1),Sb(1,4),'o','MarkerSize',8,'MarkerFaceColor',[0.8 0.1 0.1],'MarkerEdgeColor','k');
hE = plot(Sb(1,2),Sb(1,5),'o','MarkerSize',8,'MarkerFaceColor',[0.1 0.3 0.8],'MarkerEdgeColor','k');
hF = plot(Sb(1,3),Sb(1,6),'o','MarkerSize',8,'MarkerFaceColor',[0.1 0.6 0.1],'MarkerEdgeColor','k');
xlabel('x, м')
ylabel('y, м')
title('Астероид в гравитационном поле двойной звезды')

% Задание 3. Спутник Земли без учета и с учетом возмущения Луны
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
plot(S0(:,3),S0(:,4),'-','Color',[0.1 0.6 0.1],'LineWidth',1.2)
plot(0,0,'o','MarkerSize',12,'MarkerFaceColor',[0.2 0.5 1],'MarkerEdgeColor','k')
text(0.04*lim,0.04*lim,'A_0,A_n','FontSize',10)
plot(S0(end,3),S0(end,4),'o','MarkerSize',8,'MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor','k')
text(S0(end,3)+0.04*lim,S0(end,4)+0.04*lim,'B_n','FontSize',10)
plot(S0(1,3),S0(1,4),'o','MarkerSize',8,'MarkerFaceColor',[1 1 1],'MarkerEdgeColor','k')
text(S0(1,3)+0.04*lim,S0(1,4)+0.04*lim,'B_0','FontSize',10)
mA0 = plot(S0(1,3),S0(1,4),'o','MarkerSize',7,'MarkerFaceColor',[0.1 0.6 0.1],'MarkerEdgeColor','k');
xlabel('x, м')
ylabel('y, м')
title('а - без учета возмущения Луны')
subplot(1,2,2)
hold on
grid on
axis equal
xlim([-lim lim])
ylim([-lim lim])
plot(S1(:,3),S1(:,4),'-','Color',[0.1 0.6 0.1],'LineWidth',1.2)
plot(S1(:,1),S1(:,2),'-','Color',[0.8 0.1 0.1],'LineWidth',1.2)
plot(0,0,'o','MarkerSize',12,'MarkerFaceColor',[0.2 0.5 1],'MarkerEdgeColor','k')
text(0.04*lim,0.04*lim,'A_0,A_n','FontSize',10)
plot(S1(end,3),S1(end,4),'o','MarkerSize',8,'MarkerFaceColor',[0.3 0.3 0.3],'MarkerEdgeColor','k')
text(S1(end,3)+0.04*lim,S1(end,4)+0.04*lim,'B_n','FontSize',10)
plot(S1(1,3),S1(1,4),'o','MarkerSize',8,'MarkerFaceColor',[1 1 1],'MarkerEdgeColor','k')
text(S1(1,3)+0.04*lim,S1(1,4)+0.04*lim,'B_0','FontSize',10)
plot(S1(end,1),S1(end,2),'o','MarkerSize',10,'MarkerFaceColor',[0.6 0.6 0.6],'MarkerEdgeColor','k')
text(S1(end,1)+0.04*lim,S1(end,2)+0.04*lim,'C_n','FontSize',10)
plot(S1(1,1),S1(1,2),'o','MarkerSize',10,'MarkerFaceColor',[1 1 1],'MarkerEdgeColor','k')
text(S1(1,1)+0.04*lim,S1(1,2)+0.04*lim,'C_0','FontSize',10)
mB0 = plot(S1(1,3),S1(1,4),'o','MarkerSize',7,'MarkerFaceColor',[0.1 0.6 0.1],'MarkerEdgeColor','k');
mC0 = plot(S1(1,1),S1(1,2),'o','MarkerSize',8,'MarkerFaceColor',[0.8 0.1 0.1],'MarkerEdgeColor','k');
xlabel('x, м')
ylabel('y, м')
title('б - с учетом возмущения Луны')

ka = 1:2:length(ta);
kb = 1:8:length(tb);
kc = 1:2:length(tc);
c = 0;
while ishandle(fig1) || ishandle(fig2) || ishandle(fig3)
    c = c+1;
    if ishandle(fig1)
        k = ka(mod(c-1,length(ka))+1);
        set(hA,'XData',Sa(k,1),'YData',Sa(k,4))
        set(hB,'XData',Sa(k,2),'YData',Sa(k,5))
        set(hC,'XData',Sa(k,3),'YData',Sa(k,6))
    end
    if ishandle(fig2)
        k = kb(mod(c-1,length(kb))+1);
        set(hD,'XData',Sb(k,1),'YData',Sb(k,4))
        set(hE,'XData',Sb(k,2),'YData',Sb(k,5))
        set(hF,'XData',Sb(k,3),'YData',Sb(k,6))
    end
    if ishandle(fig3)
        k = kc(mod(c-1,length(kc))+1);
        set(mA0,'XData',S0(k,3),'YData',S0(k,4))
        set(mB0,'XData',S1(k,3),'YData',S1(k,4))
        set(mC0,'XData',S1(k,1),'YData',S1(k,2))
    end
    drawnow
    pause(0.03)
end

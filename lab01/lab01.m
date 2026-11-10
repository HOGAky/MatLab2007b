clear
clc
close all
r = 5.3e-4;
rho = 13.55e3;
rho0 = 1.26e3;
mu = 1.48;
g = 9.81;
[t,Y] = ode45(@(tt,ss) rhs1(tt,ss,r,rho,rho0,mu,g),0:1e-3:2,[0;0]);
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
t1 = t;
rm = r*1e3;
yc = -rm-y*1e3;
H = rm+1e3*max(y)+0.25*1e3*max(y)+2*rm;
th = linspace(0,2*pi,40);
fig1 = figure;
hold on
grid on
fill([-4 4 4 -4],[-H -H 0 0],[0.85 0.9 1],'EdgeColor','none')
plot([-4 -4 4 4],[1.5 -H -H 1.5],'k-','LineWidth',2)
plot([-4 4],[0 0],'b-')
ht1 = plot(0,yc(1),'-','Color',[0.4 0.4 0.8]);
hb1 = fill(rm*cos(th),yc(1)+rm*sin(th),[0.6 0.6 0.7]);
axis equal
axis([-6 6 -H-1 2.5])
xlabel('x, мм')
ylabel('y, мм')
hti1 = title('Падение ртутного шарика в глицерине, t = 0.00 с');
r = 1e-3;
rho = 7.8e3;
rho0 = 1e3;
mu = 1e-3;
[t,Y] = ode45(@(tt,ss) rhs1(tt,ss,r,rho,rho0,mu,g),0:0.02:8,[0;0]);
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
t2 = t;
y2 = y;
H = 1.15*max(y)+5;
fig2 = figure;
hold on
grid on
fill([-2 2 2 -2],[-H -H 0 0],[0.8 0.9 1],'EdgeColor','none')
plot([-2 -2 2 2],[0.1*H -H -H 0.1*H],'k-','LineWidth',2)
plot([-2 2],[0 0],'b-')
xlim([-4 4])
ylim([-H-0.05*H 0.15*H])
xlabel('x, м')
ylabel('y, м')
hti2 = title('Падение стального шарика в воде, t = 0.00 с');
hb2 = plot(0,0,'o','MarkerSize',12,'MarkerFaceColor',[0.2 0.4 0.8],'MarkerEdgeColor','k');
n1 = length(t1);
n2 = length(t2);
k1 = unique([1:10:n1 n1]);
k2 = unique([1:2:n2 n2]);
c = 0;
while ishandle(fig1) || ishandle(fig2)
    c = c+1;
    if ishandle(fig1)
        k = k1(mod(c-1,length(k1))+1);
        set(hb1,'XData',rm*cos(th),'YData',yc(k)+rm*sin(th))
        set(ht1,'XData',zeros(1,k),'YData',yc(1:k))
        set(hti1,'String',['Падение ртутного шарика в глицерине, t = ',num2str(t1(k),'%.2f'),' с'])
    end
    if ishandle(fig2)
        k = k2(mod(c-1,length(k2))+1);
        set(hb2,'XData',0,'YData',-y2(k))
        set(hti2,'String',['Падение стального шарика в воде, t = ',num2str(t2(k),'%.2f'),' с'])
    end
    drawnow
    pause(0.04)
end

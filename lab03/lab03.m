clear
clc
close all
rho0 = 1.204;
g = 9.81;
r = 0.11;
m = 0.45;
Cd = 0.5;
kk = 0.6;
v0 = 35;
alpha = 40*pi/180;
beta = 27*pi/180;
adec = 0.05;
s0 = [0;0;0;v0*cos(alpha)*cos(beta);v0*cos(alpha)*sin(beta);v0*sin(alpha)];
[t,s] = ode45(@(tt,ss) rhs3(tt,ss,rho0,r,m,Cd,kk,adec,g),0:0.01:5,s0);
x = s(:,1);
y = s(:,2);
z = s(:,3);
vx = s(:,4);
vy = s(:,5);
vz = s(:,6);
v = sqrt(vx.^2+vy.^2+vz.^2);
iend = max(find(z>=0));
if iend < length(z)
    f = z(iend)/(z(iend)-z(iend+1));
    x = [x(1:iend);x(iend)+f*(x(iend+1)-x(iend))];
    y = [y(1:iend);y(iend)+f*(y(iend+1)-y(iend))];
    v = [v(1:iend);v(iend)+f*(v(iend+1)-v(iend))];
    t = [t(1:iend);t(iend)+f*(t(iend+1)-t(iend))];
    z = [z(1:iend);0];
end
figure
subplot(1,2,1)
plot3(x,y,z,'LineWidth',1.5)
hold on
plot3(x,y,zeros(size(x)),'k:')
plot3(x(1),y(1),z(1),'gs','MarkerSize',9,'MarkerFaceColor','g')
plot3(x(end),y(end),0,'rs','MarkerSize',9,'MarkerFaceColor','r')
grid on
xlabel('x, м')
ylabel('y, м')
zlabel('z, м')
title('“раектори€ полета м€ча')
view(3)
subplot(1,2,2)
plot(t,v,'LineWidth',1.5)
grid on
xlabel('t, с')
ylabel('v, м/с')
title('—корость м€ча')
L = max([max(x)-min(x),max(y)-min(y),max(z)]);
rb = 0.02*L;
x1 = min(x)-0.1*L;
x2 = max(x)+0.1*L;
y1 = min(y)-0.1*L;
y2 = max(y)+0.1*L;
z2 = max(z)+3*rb;
[sxb,syb,szb] = sphere(16);
sxb = rb*sxb;
syb = rb*syb;
szb = rb*szb;
fig = figure;
hold on
grid on
patch([x1 x2 x2 x1],[y1 y1 y2 y2],[0 0 0 0],[0.6 0.8 0.5],'EdgeColor','none')
plot3(x,y,zeros(size(x)),'k:')
hb = surf(x(1)+sxb,y(1)+syb,z(1)+rb+szb,'FaceColor',[1 0.55 0.1],'EdgeColor','none');
ht = plot3(x(1),y(1),z(1)+rb,'b-','LineWidth',1.5);
axis equal
axis([x1 x2 y1 y2 0 z2])
xlabel('x, м')
ylabel('y, м')
zlabel('z, м')
title('јнимаци€ полета вращающегос€ м€ча')
ax = gca;
n = length(x);
while ishandle(fig)
    for j = unique([1:3:n n])
        if ~ishandle(fig)
            break
        end
        set(hb,'XData',x(j)+sxb,'YData',y(j)+syb,'ZData',z(j)+rb+szb)
        set(ht,'XData',x(1:j),'YData',y(1:j),'ZData',z(1:j)+rb)
        view(ax,35+40*sin(j/40),20+15*cos(j/55))
        drawnow
        pause(0.08)
    end
end
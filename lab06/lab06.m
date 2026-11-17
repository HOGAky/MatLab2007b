clear
clc
close all
g = 9.81;
m = 2;
a = 0.5;
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
title('”глова€ скорость ма€тника')
subplot(2,1,2)
plot(t,phi,'LineWidth',1.4)
grid on
xlabel('t, с')
ylabel('\phi, рад')
title('”гол отклонени€ центра масс')
figure
plot(phi,w,'LineWidth',1.4)
grid on
xlabel('\phi, рад')
ylabel('\omega, рад/с')
title('‘азова€ траектори€ центра масс')
fig = figure;
axis equal
hold on
grid on
depth = 0.06;
R = 2*l+max(a,c)/2+depth+0.15;
xlim([-1.3*R 1.3*R])
ylim([-1.3*R 0.5*R])
xlabel('x, м')
ylabel('y, м')
title('—вободные колебани€ физического ма€тника')
plot(0,0,'k+','MarkerSize',12,'LineWidth',2)
[px,py,pz,F] = rectpts(l*sin(phi(1)),-l*cos(phi(1)),a,b,c,l,phi(1),depth);
hr = patch('Vertices',[px(:) py(:) pz(:)],'Faces',F,'FaceColor',[0.75 0.5 0.3],'EdgeColor',[0.4 0.25 0.1],'LineWidth',0.8);
hrod = plot([0 l*sin(phi(1))],[0 -l*cos(phi(1))],'k-','LineWidth',2);
while ishandle(fig)
    for k = 1:4:length(t)
        if ~ishandle(fig)
            break
        end
        xc = l*sin(phi(k));
        yc = -l*cos(phi(k));
        [px,py,pz,F] = rectpts(xc,yc,a,b,c,l,phi(k),depth);
        set(hr,'Vertices',[px(:) py(:) pz(:)])
        set(hrod,'XData',[0 xc],'YData',[0 yc])
        drawnow
        pause(0.04)
    end
end

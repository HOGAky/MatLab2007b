clear
clc
close all
g = 9.81;
m = 2;
a = 0.5;
b = 0.3;
c = 0.3;
l = 0.15;
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
hold on
grid on
plot(phi,w,'LineWidth',1.4)
n = length(phi);
idp = unique(round(linspace(1,n,5)));
labs = {'A_0','A_k','A_l','A_m','A_n'};
cols = [1 1 1; 0.2 0.6 1; 0.2 0.6 1; 0.2 0.6 1; 0.5 0.5 0.5];
for j = 1:5
    plot(phi(idp(j)),w(idp(j)),'o','MarkerSize',9,'MarkerFaceColor',cols(j,:),'MarkerEdgeColor','k')
    text(phi(idp(j))+0.03,w(idp(j))+0.06,labs{j},'FontSize',10)
end
xlabel('\phi, рад')
ylabel('\omega, рад/с')
title('‘азова€ траектори€ центра масс')
fig = figure;
hold on
grid on
view(35,20)
axis equal
L = a/2+0.15;
axis([-(l+max(b,c)/2+0.15) l+max(b,c)/2+0.15 -(l+max(b,c)/2+0.3) 0.3*L -L L])
xlabel('x, м')
ylabel('y, м')
zlabel('z, м')
title('—вободные колебани€ физического ма€тника')
plot3(0,0,0,'ko','MarkerSize',10,'MarkerFaceColor','w','MarkerEdgeColor','k')
hO = plot3([0 0],[0 0],[-L L],'k-','LineWidth',2.5);
hC = plot3([0 -l],[0 -l],[-L L],'k--','LineWidth',1.5);
[px,py,pz,F] = rectpts(phi(1),l,b,c,a);
hr = patch('Vertices',[px(:) py(:) pz(:)],'Faces',F,'FaceColor',[0.75 0.5 0.3],'EdgeColor',[0.4 0.25 0.1],'LineWidth',0.8);
while ishandle(fig)
    for k = 1:4:length(t)
        if ~ishandle(fig)
            break
        end
        xc = l*sin(phi(k));
        yc = -l*cos(phi(k));
        [px,py,pz,F] = rectpts(phi(k),l,b,c,a);
        set(hr,'Vertices',[px(:) py(:) pz(:)])
        set(hC,'XData',[xc xc],'YData',[yc yc])
        drawnow
        pause(0.04)
    end
end

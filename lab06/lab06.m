clear
clc
close all
g = 9.81;
m = 2;
b = 0.3;
c = 0.4;
l = 0.2;
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
axis equal
axis([-0.5 0.5 -0.55 0.15])
xlabel('x, м')
ylabel('y, м')
title('—вободные колебани€ физического ма€тника')
plot([-0.4 0.4],[0 0],'k-','LineWidth',2.5)
text(-0.4,0.03,'OO''','FontSize',12,'FontWeight','bold')
plot(0,0,'ko','MarkerSize',8,'MarkerFaceColor','w','MarkerEdgeColor','k')
text(0.02,0.03,'O','FontSize',12)
hC = plot([0 0],[0 0],'k--','LineWidth',1.2);
hp = plot(0,0,'o','MarkerSize',8,'MarkerFaceColor','y','MarkerEdgeColor','k');
hT = text(0.26,-0.2,'CC''','FontSize',12);
cb = [-b/2 b/2 b/2 -b/2 -b/2];
ch = [ c/2  c/2 -c/2 -c/2  c/2];
hr = patch('XData',[0 0 0 0 0],'YData',[0 0 0 0 0],'FaceColor',[0.75 0.5 0.3],'EdgeColor',[0.4 0.25 0.1],'LineWidth',1);
while ishandle(fig)
    for k = 1:4:length(t)
        if ~ishandle(fig)
            break
        end
        ph = phi(k);
        xc = l*sin(ph);
        yc = -l*cos(ph);
        cp = cos(ph);
        sp = sin(ph);
        px = xc + cb*cp - ch*sp;
        py = yc + cb*sp + ch*cp;
        set(hr,'XData',px,'YData',py)
        set(hC,'XData',[xc-0.25 xc+0.25],'YData',[yc yc])
        set(hp,'XData',xc,'YData',yc)
        set(hT,'Position',[xc+0.26 yc+0.03])
        drawnow
        pause(0.04)
    end
end

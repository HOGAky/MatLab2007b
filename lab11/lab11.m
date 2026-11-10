clear
clc
close all
E = 5e4;
B = 0.5;
alpha = 20*pi/180;
v0 = 2e5;
mp = 1.67e-27;
qp = 1.6e-19;
me = 9.11e-31;
qe = -1.6e-19;
ms = [mp me];
qs = [qp qe];
names = {'Протон','Электрон'};
fig = zeros(1,2);
hp = zeros(1,2);
ht = zeros(1,2);
xs = cell(1,2);
ys = cell(1,2);
for p = 1:2
    m = ms(p);
    q = qs(p);
    Tc = 2*pi*m/(abs(q)*B);
    s0 = [0;0;v0*cos(alpha);v0*sin(alpha)];
    [t,s] = ode45(@(tt,ss) lorentz_rhs(tt,ss,m,q,E,B),linspace(0,4*Tc,1000),s0);
    x = s(:,1);
    y = s(:,2);
    vx = s(:,3);
    vy = s(:,4);
    v = sqrt(vx.^2+vy.^2);
    xs{p} = x;
    ys{p} = y;
    fig(p) = figure;
    subplot(1,2,1)
    hold on
    grid on
    axis equal
    xlabel('x, м')
    ylabel('y, м')
    title(['Движение: ',names{p}])
    hp(p) = plot(x(1),y(1),'o','MarkerSize',9,'MarkerFaceColor','r','MarkerEdgeColor','k');
    ht(p) = plot(x(1),y(1),'b-','LineWidth',1);
    pad = 0.08*max(max(x)-min(x),max(y)-min(y));
    axis([min(x)-pad max(x)+pad min(y)-pad max(y)+pad])
    subplot(1,2,2)
    plot(t,v,'LineWidth',1.4)
    grid on
    xlabel('t, с')
    ylabel('v, м/с')
    title('Скорость частицы')
end
ks = 1:5:length(xs{1});
c = 0;
while any(ishandle(fig))
    c = c+1;
    k = ks(mod(c-1,length(ks))+1);
    for p = 1:2
        if ishandle(fig(p))
            set(hp(p),'XData',xs{p}(k),'YData',ys{p}(k))
            set(ht(p),'XData',xs{p}(1:k),'YData',ys{p}(1:k))
        end
    end
    drawnow
    pause(0.04)
end

clear
clc
close all
A = 1;
nu = 2;
v = 3;
om = 2*pi*nu;
kk = om/v;
lam = v/nu;
x1 = 6;
x = linspace(0,x1,1200);
t0 = 0.5;
xn = x1-(0:floor(x1/(lam/2)))*lam/2;
xi1 = A*cos(om*t0-kk*(x-x1));
xi2 = A*cos(om*t0+kk*(x-x1)+pi);
xi = xi1+xi2;
figure
hold on
grid on
plot(x,xi1,'--','LineWidth',1.1)
plot(x,xi2,'--','LineWidth',1.1)
plot(x,xi,'r-','LineWidth',1.8)
plot(xn,zeros(size(xn)),'ko','MarkerSize',7,'MarkerFaceColor','k')
plot([x1 x1],[-2.2 2.2],'k-','LineWidth',3)
xlabel('x, м')
ylabel('\xi, м')
ylim([-2.2 2.2])
title('Образование стоячей волны')
legend('Набегающая волна','Отраженная волна','Стоячая волна','Узлы','Препятствие','Location','best')
fig = figure;
hold on
grid on
h1 = plot(x,xi1,'--','LineWidth',1);
h2 = plot(x,xi2,'--','LineWidth',1);
h3 = plot(x,xi,'r-','LineWidth',1.8);
plot(xn,zeros(size(xn)),'ko','MarkerSize',6,'MarkerFaceColor','k')
plot([x1 x1],[-2.2 2.2],'k-','LineWidth',3)
xlabel('x, м')
ylabel('\xi, м')
ylim([-2.2 2.2])
hti = title('Стоячая волна, t = 0.00 с');
while ishandle(fig)
    for tt = linspace(0,3,160)
        if ~ishandle(fig)
            break
        end
        xi1 = A*cos(om*tt-kk*(x-x1));
        xi2 = A*cos(om*tt+kk*(x-x1)+pi);
        xi = xi1+xi2;
        set(h1,'YData',xi1)
        set(h2,'YData',xi2)
        set(h3,'YData',xi)
        set(hti,'String',['Стоячая волна, t = ',num2str(tt,'%.2f'),' с'])
        drawnow
        pause(0.05)
    end
end
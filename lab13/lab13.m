clear
clc
close all
A0 = 1;
nu = 2;
v = 3;
phi0 = 0;
x = linspace(-6,6,200);
y = linspace(-5,5,160);
[X,Y] = meshgrid(x,y);
R = sqrt(X.^2+Y.^2);
t0 = 0.6;
Z = A0*cos(2*pi*nu*t0-2*pi*nu*R/v+phi0)./sqrt(R.^2+1);
figure
surf(X,Y,Z,'EdgeColor','none')
xlabel('x, м')
ylabel('y, м')
zlabel('\xi, м')
title('Сферическая волна в фиксированный момент времени')
colorbar
fig1 = figure;
hs1 = surf(X,Y,Z,'EdgeColor','none');
xlabel('x, м')
ylabel('y, м')
zlabel('\xi, м')
ht1 = title('Распространение сферической волны');
colorbar
caxis([-0.5 1])
x1 = -2;
x2 = 2;
R1 = sqrt((X-x1).^2+Y.^2);
R2 = sqrt((X-x2).^2+Y.^2);
Z = A0*cos(-2*pi*nu*R1/v)./sqrt(R1.^2+1)+A0*cos(-2*pi*nu*R2/v)./sqrt(R2.^2+1);
fig2 = figure;
hs2 = surf(X,Y,Z,'EdgeColor','none');
view(2)
axis equal
axis tight
xlabel('x, м')
ylabel('y, м')
ht2 = title('Интерференция волн от двух когерентных источников');
colorbar
caxis([-1 1])
ts = linspace(0,4,140);
c = 0;
while ishandle(fig1) || ishandle(fig2)
    c = c+1;
    tt = ts(mod(c-1,length(ts))+1);
    if ishandle(fig1)
        Z = A0*cos(2*pi*nu*tt-2*pi*nu*R/v+phi0)./sqrt(R.^2+1);
        set(hs1,'ZData',Z,'CData',Z)
        set(ht1,'String',['Распространение сферической волны, t = ',num2str(tt,'%.2f'),' с'])
    end
    if ishandle(fig2)
        Z = A0*cos(2*pi*nu*tt-2*pi*nu*R1/v+phi0)./sqrt(R1.^2+1)+A0*cos(2*pi*nu*tt-2*pi*nu*R2/v+phi0)./sqrt(R2.^2+1);
        set(hs2,'ZData',Z,'CData',Z)
        set(ht2,'String',['Интерференция волн, t = ',num2str(tt,'%.2f'),' с'])
    end
    drawnow
    pause(0.05)
end
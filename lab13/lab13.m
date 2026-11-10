% Лабораторная работа №13
clear
clc
close all
labdir = fileparts(mfilename('fullpath'));
if ~isempty(labdir)
    cd(labdir)
end
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
figure
hs = surf(X,Y,Z,'EdgeColor','none');
xlabel('x, м')
ylabel('y, м')
zlabel('\xi, м')
title('Распространение сферической волны')
colorbar
caxis([-0.5 1])
for tt = linspace(0,4,140)
    Z = A0*cos(2*pi*nu*tt-2*pi*nu*R/v+phi0)./sqrt(R.^2+1);
    set(hs,'ZData',Z)
    title(['Распространение сферической волны, t = ',num2str(tt,'%.2f'),' с'])
    drawnow
end
x1 = -2;
x2 = 2;
R1 = sqrt((X-x1).^2+Y.^2);
R2 = sqrt((X-x2).^2+Y.^2);
Z = A0*cos(-2*pi*nu*R1/v)./sqrt(R1.^2+1)+A0*cos(-2*pi*nu*R2/v)./sqrt(R2.^2+1);
figure
hs = surf(X,Y,Z,'EdgeColor','none');
view(2)
axis equal
axis tight
xlabel('x, м')
ylabel('y, м')
title('Интерференция волн от двух когерентных источников')
colorbar
caxis([-1 1])
for tt = linspace(0,4,140)
    Z = A0*cos(2*pi*nu*tt-2*pi*nu*R1/v+phi0)./sqrt(R1.^2+1)+A0*cos(2*pi*nu*tt-2*pi*nu*R2/v+phi0)./sqrt(R2.^2+1);
    set(hs,'ZData',Z)
    title(['Интерференция волн, t = ',num2str(tt,'%.2f'),' с'])
    drawnow
end

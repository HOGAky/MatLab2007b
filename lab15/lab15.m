% Лабораторная работа №15
clear
clc
close all
A0 = 1;
z = 0.5;
lam = 633e-9;
phi0 = 0;
N = 180;
L = 8e-3;
x = linspace(-L/2,L/2,N);
y = x;
[X,Y] = meshgrid(x,y);
b = 2e-4;
Ls = 4e-3;
nb = 9;
nl = 60;
[sx,sy] = meshgrid(linspace(-b/2,b/2,nb),linspace(-Ls/2,Ls/2,nl));
sx = sx(:);
sy = sy(:);
dS = (b/nb)*(Ls/nl);
E = field_sum(X,Y,sx,sy,dS,A0,z,lam,phi0);
I = E.^2;
figure
subplot(1,2,1)
imagesc(x*1e3,y*1e3,I)
axis xy
axis image
colorbar
xlabel('x, мм')
ylabel('y, мм')
title('Дифракция на щели')
subplot(1,2,2)
plot(x*1e3,I(round(N/2),:),'LineWidth',1.4)
grid on
xlabel('x, мм')
ylabel('I')
title('Профиль интенсивности')
figure
for a = 1e-4:0.25e-4:3.5e-4
    na = max(4,round(30*a/5e-4));
    [sx,sy] = meshgrid(linspace(-a/2,a/2,na),linspace(-a/2,a/2,na));
    sx = sx(:);
    sy = sy(:);
    dS = (a/na)^2;
    E = field_sum(X,Y,sx,sy,dS,A0,z,lam,phi0);
    I = E.^2;
    imagesc(x*1e3,y*1e3,I)
    axis xy
    axis image
    colorbar
    xlabel('x, мм')
    ylabel('y, мм')
    title(['Квадратное отверстие, сторона ',num2str(a*1e3,'%.2f'),' мм'])
    drawnow
end
figure
nr = 7;
nt = 48;
for rr = 0.5e-4:0.25e-4:2e-4
    sx = [];
    sy = [];
    for ir = 1:nr
        rad = rr*ir/nr;
        th = linspace(0,2*pi,nt*ir+1);
        th = th(1:end-1);
        sx = [sx rad*cos(th)];
        sy = [sy rad*sin(th)];
    end
    sx = [sx 0];
    sy = [sy 0];
    sx = sx(:);
    sy = sy(:);
    dS = pi*rr^2/length(sx);
    E = field_sum(X,Y,sx,sy,dS,A0,z,lam,phi0);
    I = E.^2;
    imagesc(x*1e3,y*1e3,I)
    axis xy
    axis image
    colorbar
    xlabel('x, мм')
    ylabel('y, мм')
    title(['Круглое отверстие, радиус ',num2str(rr*1e3,'%.2f'),' мм'])
    drawnow
end

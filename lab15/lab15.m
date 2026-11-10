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
as = 1e-4:0.25e-4:3.5e-4;
Isq = cell(1,length(as));
for ia = 1:length(as)
    a = as(ia);
    na = max(4,round(30*a/5e-4));
    [sx,sy] = meshgrid(linspace(-a/2,a/2,na),linspace(-a/2,a/2,na));
    sx = sx(:);
    sy = sy(:);
    dS = (a/na)^2;
    E = field_sum(X,Y,sx,sy,dS,A0,z,lam,phi0);
    Isq{ia} = E.^2;
end
nr = 7;
nt = 48;
rs = 0.5e-4:0.25e-4:2e-4;
Icr = cell(1,length(rs));
for ir0 = 1:length(rs)
    rr = rs(ir0);
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
    Icr{ir0} = E.^2;
end
fig1 = figure;
him1 = imagesc(x*1e3,y*1e3,Isq{1});
ax1 = gca;
axis xy
axis image
colorbar
xlabel('x, мм')
ylabel('y, мм')
ht1 = title('Квадратное отверстие');
fig2 = figure;
him2 = imagesc(x*1e3,y*1e3,Icr{1});
ax2 = gca;
axis xy
axis image
colorbar
xlabel('x, мм')
ylabel('y, мм')
ht2 = title('Круглое отверстие');
c = 0;
while ishandle(fig1) || ishandle(fig2)
    c = c+1;
    if ishandle(fig1)
        ia = mod(c-1,length(as))+1;
        set(him1,'CData',Isq{ia})
        set(ax1,'CLim',[0 max(Isq{ia}(:))])
        set(ht1,'String',['Квадратное отверстие, сторона ',num2str(as(ia)*1e3,'%.2f'),' мм'])
    end
    if ishandle(fig2)
        ir0 = mod(c-1,length(rs))+1;
        set(him2,'CData',Icr{ir0})
        set(ax2,'CLim',[0 max(Icr{ir0}(:))])
        set(ht2,'String',['Круглое отверстие, радиус ',num2str(rs(ir0)*1e3,'%.2f'),' мм'])
    end
    drawnow
    pause(0.3)
end
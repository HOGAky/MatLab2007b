% Лабораторная работа №9
clear
clc
close all
m = [1 1.1 0.9];
k = [15 12 18 14];
Fm = [1.2 0.8 1.0];
nu = [0.8 1.1 0.9];
fi = [0 pi/4 pi/2];
x0 = [0.08 -0.04 0.05];
v0 = [0 0 0];
s0 = [x0(:);v0(:)];
[t,S] = ode45('forced3_rhs',0:0.01:30,s0,[],m,k,Fm,nu,fi);
x = S(:,1:3);
v = S(:,4:6);
figure
plot(t,x,'LineWidth',1.2)
grid on
xlabel('t, с')
ylabel('x, м')
title('Смещения грузов')
legend('1','2','3','Location','best')
figure
plot(t,v,'LineWidth',1.2)
grid on
xlabel('t, с')
ylabel('v, м/с')
title('Скорости грузов')
legend('1','2','3','Location','best')
figure
for i = 1:3
    subplot(1,3,i)
    plot(x(:,i),v(:,i),'LineWidth',1.1)
    grid on
    xlabel('x, м')
    ylabel('v, м/с')
    title(['Маятник ',num2str(i)])
end
figure
hold on
grid on
xpos = 1:3;
xw0 = 0;
xw1 = 4;
xlim([xw0-0.5 xw1+0.5])
ylim([-0.6 0.6])
plot([xw0 xw0],[-0.4 0.4],'k-','LineWidth',4)
plot([xw1 xw1],[-0.4 0.4],'k-','LineWidth',4)
xa = [xw0 xpos xw1];
hs = zeros(4,1);
xx = [0 x(1,:) 0];
for j = 1:4
    [sx,sy] = spring_draw(xa(j)+xx(j),0,xa(j+1)+xx(j+1),0,0.06);
    hs(j) = plot(sx,sy,'b-','LineWidth',1);
end
hm = plot(xpos+x(1,:),zeros(1,3),'o','MarkerSize',15,'MarkerFaceColor',[0.4 0.7 0.4],'MarkerEdgeColor','k');
xlabel('x, м')
title('Вынужденные колебания трех связанных грузов')
for n = 1:5:length(t)
    xx = [0 x(n,:) 0];
    set(hm,'XData',xpos+x(n,:))
    for j = 1:4
        [sx,sy] = spring_draw(xa(j)+xx(j),0,xa(j+1)+xx(j+1),0,0.06);
        set(hs(j),'XData',sx,'YData',sy)
    end
    drawnow
end

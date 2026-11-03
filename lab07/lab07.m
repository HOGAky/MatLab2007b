% Лабораторная работа №7
clear
clc
close all
m = [1 1.2 0.8 1.1 0.9];
k = [15 12 18 14 16 13];
x0 = [0.1 -0.05 0.08 0 0.06];
v0 = [0 0.15 0 0.1 0];
s0 = [x0(:);v0(:)];
[t,S] = ode45(@(tt,ss) chain5_rhs(tt,ss,m,k),0:0.01:20,s0);
x = S(:,1:5);
v = S(:,6:10);
figure
plot(t,x,'LineWidth',1.2)
grid on
xlabel('t, с')
ylabel('x, м')
title('Смещения грузов')
legend('1','2','3','4','5','Location','best')
figure
plot(t,v,'LineWidth',1.2)
grid on
xlabel('t, с')
ylabel('v, м/с')
title('Скорости грузов')
legend('1','2','3','4','5','Location','best')
figure
for i = 1:5
    subplot(3,2,i)
    plot(x(:,i),v(:,i),'LineWidth',1.1)
    grid on
    xlabel('x, м')
    ylabel('v, м/с')
    title(['Маятник ',num2str(i)])
end
figure
hold on
grid on
xpos = 1:5;
xw0 = 0;
xw1 = 6;
xlim([xw0-0.5 xw1+0.5])
ylim([-0.6 0.6])
plot([xw0 xw0],[-0.4 0.4],'k-','LineWidth',4)
plot([xw1 xw1],[-0.4 0.4],'k-','LineWidth',4)
xa = [xw0 xpos xw1];
hs = zeros(6,1);
xx = [0 x(1,:) 0];
for j = 1:6
    [sx,sy] = spring_draw(xa(j)+xx(j),0,xa(j+1)+xx(j+1),0,0.06);
    hs(j) = plot(sx,sy,'b-','LineWidth',1);
end
hm = plot(xpos+x(1,:),zeros(1,5),'o','MarkerSize',14,'MarkerFaceColor',[0.8 0.3 0.3],'MarkerEdgeColor','k');
xlabel('x, м')
title('Собственные колебания пяти связанных грузов')
for n = 1:5:length(t)
    xx = [0 x(n,:) 0];
    set(hm,'XData',xpos+x(n,:))
    for j = 1:6
        [sx,sy] = spring_draw(xa(j)+xx(j),0,xa(j+1)+xx(j+1),0,0.06);
        set(hs(j),'XData',sx,'YData',sy)
    end
    drawnow
end

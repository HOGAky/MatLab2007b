% Лабораторная работа №8
clear
clc
close all
m = [1 1.2];
k = [15 10 12];
kc = [0.45 0.6];
y0 = [0.12 -0.08];
v0 = [0 0];
s0 = [y0(:);v0(:)];
[t,S] = ode45(@(tt,ss) damp2_rhs(tt,ss,m,k,kc),0:0.01:20,s0);
y = S(:,1:2);
v = S(:,3:4);
figure
plot(t,y,'LineWidth',1.2)
grid on
xlabel('t, с')
ylabel('y, м')
title('Смещения грузов')
legend('1','2','Location','best')
figure
plot(t,v,'LineWidth',1.2)
grid on
xlabel('t, с')
ylabel('v, м/с')
title('Скорости грузов')
legend('1','2','Location','best')
figure
subplot(1,2,1)
plot(y(:,1),v(:,1),'LineWidth',1.1)
grid on
xlabel('y_1, м')
ylabel('v_1, м/с')
title('Маятник 1')
subplot(1,2,2)
plot(y(:,2),v(:,2),'LineWidth',1.1)
grid on
xlabel('y_2, м')
ylabel('v_2, м/с')
title('Маятник 2')
figure
hold on
grid on
ya = [0 1 2.2 3.4];
xlim([-0.7 0.7])
ylim([ya(1)-0.4 ya(4)+0.4])
plot([-0.4 0.4],[ya(1) ya(1)],'k-','LineWidth',4)
plot([-0.4 0.4],[ya(4) ya(4)],'k-','LineWidth',4)
hs = zeros(3,1);
yy = [0 y(1,:) 0];
for j = 1:3
    [sx,sy] = spring_draw(0,ya(j)+yy(j),0,ya(j+1)+yy(j+1),0.12);
    hs(j) = plot(sx,sy,'b-','LineWidth',1);
end
hm = plot(zeros(1,2),ya(2:3)+y(1,:),'o','MarkerSize',16,'MarkerFaceColor',[0.3 0.5 0.85],'MarkerEdgeColor','k');
ylabel('y, м')
title('Затухающие колебания двух связанных грузов')
for n = 1:5:length(t)
    yy = [0 y(n,:) 0];
    set(hm,'YData',ya(2:3)+y(n,:))
    for j = 1:3
        [sx,sy] = spring_draw(0,ya(j)+yy(j),0,ya(j+1)+yy(j+1),0.12);
        set(hs(j),'XData',sx,'YData',sy)
    end
    drawnow
    pause(0.05)
end

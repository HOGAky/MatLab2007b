% Лабораторная работа №10
clear
clc
close all
labdir = fileparts(mfilename('fullpath'));
if ~isempty(labdir)
    cd(labdir)
end
L = 0.5;
C = 2e-3;
I0 = 0;
q0 = 2e-3;
U0 = q0/C;
E0 = 5;
Om = 30;
Rset = [0 15 15];
Eset = [0 0 E0];
names = {'Свободные колебания (R = 0, E0 = 0)','Затухающие колебания (R > 0, E0 = 0)','Вынужденные колебания (R > 0, E0 > 0)'};
for c = 1:3
    R = Rset(c);
    E = Eset(c);
    [t,s] = ode45(@(tt,ss) lc_rhs(tt,ss,L,C,R,E,Om),0:0.001:3,[I0;q0;U0]);
    I = s(:,1);
    q = s(:,2);
    U = s(:,3);
    figure
    subplot(3,1,1)
    plot(t,I,'LineWidth',1.1)
    grid on
    ylabel('I, А')
    title(names{c})
    subplot(3,1,2)
    plot(t,q,'LineWidth',1.1)
    grid on
    ylabel('q, Кл')
    subplot(3,1,3)
    plot(t,U,'LineWidth',1.1)
    grid on
    xlabel('t, с')
    ylabel('U, В')
end

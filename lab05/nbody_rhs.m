function ds = nbody_rhs(t,s,m,G)
x = s(1:3);
y = s(4:6);
vx = s(7:9);
vy = s(10:12);
ax = zeros(3,1);
ay = zeros(3,1);
for i = 1:3
    for j = 1:3
        if i~=j
            dx = x(j)-x(i);
            dy = y(j)-y(i);
            rr = (dx^2+dy^2)^1.5;
            ax(i) = ax(i)+G*m(j)*dx/rr;
            ay(i) = ay(i)+G*m(j)*dy/rr;
        end
    end
end
ds = [vx;vy;ax;ay];

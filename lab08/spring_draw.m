function [sx,sy] = spring_draw(xa,ya,xb,yb,amp)
n = 6;
u = (0:2*n)/(2*n);
sx = xa+(xb-xa)*u;
sy = ya+(yb-ya)*u;
sg = amp*(-1).^(1:2*n-1);
nx = -(yb-ya);
ny = xb-xa;
L = sqrt(nx^2+ny^2);
if L>0
    nx = nx/L;
    ny = ny/L;
end
sx(2:2*n) = sx(2:2*n)+nx*sg;
sy(2:2*n) = sy(2:2*n)+ny*sg;

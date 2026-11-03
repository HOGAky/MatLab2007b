function [px,py] = rectpts(xc,yc,b,c,phi)
bx = [b/2 b/2 -b/2 -b/2 b/2];
by = [c/2 -c/2 -c/2 c/2 c/2];
px = xc+bx*cos(phi)-by*sin(phi);
py = yc+bx*sin(phi)+by*cos(phi);

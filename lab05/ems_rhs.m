function ds = ems_rhs(t,s,G,Me,Mm,wm)
xm = s(1);
ym = s(2);
xs = s(3);
ys = s(4);
vxm = s(5);
vym = s(6);
vxs = s(7);
vys = s(8);
rm = (xm^2+ym^2)^1.5;
rs = (xs^2+ys^2)^1.5;
axm = -G*Me*xm/rm;
aym = -G*Me*ym/rm;
axs = -G*Me*xs/rs;
ays = -G*Me*ys/rs;
if wm
    dx = xm-xs;
    dy = ym-ys;
    rr = (dx^2+dy^2)^1.5;
    axs = axs+G*Mm*dx/rr;
    ays = ays+G*Mm*dy/rr;
end
ds = [vxm;vym;vxs;vys;axm;aym;axs;ays];

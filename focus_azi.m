t = linspace(0,1,270);
l = -1;  % vortex charge

Show_Each_Ray = 1;

m = 60; % number of rays
theta = linspace(0,2*pi-2*pi/m,m);  % position of light ray on a ring aperture
delay = l*theta; % phase delay due to vortex phase plate
theta = theta + pi/2;  % direction of polarization
E0 = 1/m; % amplitude of each ray


figure1 = figure(1);
xlim([-1.5,1.5]);ylim([-1.5,1.5]);
axis square
set(gca,'XTick',[-1.5,-1,-0.5,0,0.5,1,1.5],'YTick',[-1.5,-1,-0.5,0,0.5,1,1.5]);
grid on
hold on
vec_E = quiver(0,0,0,0,1,'-b');


if Show_Each_Ray == 1
    tmp = zeros(1,m);
    rays = quiver(tmp,tmp,tmp,tmp,m/2,'-r');
end

filename=['focus_azi_',num2str(l),'.gif']; fps=30;


for k = 2:length(t)
    rho = E0*cos(2*pi*t(k)+delay);
    [x,y] = pol2cart(theta,rho);
    Ex = sum(x); Ey = sum(y);
    
    set(vec_E,'UData',Ex,'VData',Ey);
  
    if Show_Each_Ray == 1
        set(rays,'UData',x,'VData',y);
    end  
   
    drawnow
    
    Frame=getframe(gcf);
    Image=frame2im(Frame);
    [imind,cm]=rgb2ind(Image,256);
    if k==2
        imwrite(imind,cm,filename,'gif','Loopcount',inf,'DelayTime',1/fps);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1/fps);
    end
end
close(1)
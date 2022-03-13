t = linspace(0,1,90);
rho = ones(1,length(t));
phi = 2*pi*t;
[x,y] = pol2cart(phi,rho);

figure1 = figure(1);
plot(x,y,'--r');
xlim([-1.5,1.5]);ylim([-1.5,1.5]);
axis square
set(gca,'XTick',[-1.5,-1,-0.5,0,0.5,1,1.5],'YTick',[-1.5,-1,-0.5,0,0.5,1,1.5]);
grid on
hold on
vec_E = quiver(0,0,x(1),y(1),1,'-b');

filename='circular.gif'; fps=30;

for k=2:length(t)
    set(vec_E,'UData',x(k),'VData',y(k));
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
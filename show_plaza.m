function h=show_plaza(plaza,h,n);

[L,W]=size(plaza); 
temp=plaza;
temp(temp~=0)=0;%create the palza without any cars

plaza_draw=plaza;  

PLAZA(:,:,1)=plaza_draw;
PLAZA(:,:,2)=plaza_draw;
PLAZA(:,:,3)=temp;
PLAZA=1-PLAZA;
%%If it's a self-driving car, turn the cell to red
for i=1:L
    for j=1:W
        if (PLAZA(i,j,1)<0)
                PLAZA(i,j,1)=PLAZA(i,j,1)+2;
                PLAZA(i,j,2)=PLAZA(i,j,2)+1;
                PLAZA(i,j,3)=PLAZA(i,j,3)-1;
        end
    end
end
                
%PLAZA(PLAZA<0)=PLAZA(PLAZA<0)*(-1);


if ishandle(h)
   set(h,'CData',PLAZA);
   pause(n);
else
    figure('position',[100 100 200 700]);
    h=imagesc(PLAZA);
    %colorbar;
    hold on;
    plot([[0:W]',[0:W]']+0.5,[0,L]+0.5,'k');
    plot([0,W]+0.5,[[0:L]',[0:L]']+0.5,'k');
    axis image
    set(gca, 'xtick', [], 'ytick', []);
    pause(n);
end
end
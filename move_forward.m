function [plaza,v,vmax,flux_cnt]=move_forward(plaza,v,vmax,time,probe_itvl,flux_cnt);
    [L,W]=size(plaza);%车道大小，包括边界
     %step4:计算该前进和该左转的车辆
    gap=zeros(L,W);
    %flux=zeros(L,1);
    for lanes=2:W-1;
        temp=find(plaza(:,lanes)~=0); 
        nn=length(temp);%该车道的车的数量
        for k=1:nn;
            i=temp(k);
            if(k==nn)
                gap(i,lanes)=L-(temp(k)-temp(1)+1);%为周期边界循环预处理的车距
                continue;
            end
            gap(i,lanes)=temp(k+1)-temp(k)-1;
        end
    end

    
    
     for lanes=2:W-1;
         temp=find(plaza(:,lanes)~=0);
         nn=length(temp);
         for k=1:nn;
             i=temp(k);
             if(v(i,lanes)<=gap(i,lanes))
                pos=mod(i+v(i,lanes)-1,L)+1;
             end
             if(v(i,lanes)>gap(i,lanes))
                pos=mod(i+gap(i,lanes)-1,L)+1;
             end
             %%collect the capacity of each segment of road 
             if(time>250)
                 for probe=probe_itvl:probe_itvl:L
                     if((i<probe)&&(pos>=probe))||((i<=probe)&&(pos>probe))
                         flux_cnt(probe,1)=flux_cnt(probe,1)+1;
                     end
                 end
             end
             
             if(pos~=i)
                plaza(pos,lanes)=plaza(i,lanes);
                v(pos,lanes)=v(i,lanes);
                vmax(pos,lanes)=vmax(i,lanes);
                 plaza(i,lanes)=0;
                 v(i,lanes)=0;
                 vmax(i,lanes)=0;
             end
         end
     end

end
function [Y] = paint_triangle_gouraud(I,vertices,vertex_color)

Y=I;
list_shm=2*1;
%list of active points
list_akm=2*1;
%list of active edges
ck=1*3;
cl=1*3;
cm=1*3;

for akmh=1:3
    if akmh == 3
        if (vertices(3,1)-vertices(1,1)) == 0
            vertices(akmh,7)=Inf;
            %the edge is vertical
        elseif (vertices(3,2)-vertices(1,2)) == 0
            vertices(akmh,7)=0;
            %the edge is horizontal
        else
            vertices(akmh,7) = (vertices(3,2)-vertices(1,2))/(vertices(3,1)-vertices(1,1));
            %add the slope of the edge to the array
        end
        vertices(akmh, 3) = min(vertices(3,1),vertices(1,1));
        vertices(akmh, 4) = min(vertices(3,2),vertices(1,2));
        vertices(akmh, 5) = max(vertices(3,1),vertices(1,1));
        vertices(akmh, 6) = max(vertices(3,2),vertices(1,2));
        %find xmin, xmax, ymin, ymax of the edge and add them to the array
        break;
    end
    %calculate the elements of the array for the third edge
    
    vertices(akmh, 3) = min(vertices(akmh,1), vertices(akmh+1,1));
    vertices(akmh, 4) = min(vertices(akmh,2), vertices(akmh+1,2));
    vertices(akmh, 5) = max(vertices(akmh,1), vertices(akmh+1,1));
    vertices(akmh, 6) = max(vertices(akmh,2), vertices(akmh+1,2));
    if (vertices(akmh+1,1)-vertices(akmh,1))==0
        vertices(akmh,7)=Inf;
    elseif (vertices(akmh+1,2)-vertices(akmh,2)) == 0
        vertices(akmh,7)=0;
    else
        vertices(akmh,7) = (vertices(akmh+1,2)-vertices(akmh,2))/(vertices(akmh+1,1)-vertices(akmh,1));
    end
    %calculate the elements of the array for the rest edges
end

ymin = min(vertices(:,4));
ymax = max(vertices(:,6));
%calculate ymin, ymax

c=0;
%c=0 if there is no horizontal edge, else c=1
y=1;
for i=1:3
    if vertices(i,4) == ymin && vertices(i,7)~=0
        list_akm(y,1) = i;
        y=y+1;
    end
    %find the active edges if the slope of the edge is defferent to 0
    if vertices(i,4) == ymin && vertices(i,7)==0
        for x=vertices(i,3):vertices(i,5)
            if i==3
                if vertices(1,1)<vertices(3,1)
                    cm = vector_interp(vertices(3,3),vertices(3,5),x,vertex_color(1,1:3),vertex_color(3,1:3),1);
                elseif vertices(3,1)<vertices(1,1)
                    cm = vector_interp(vertices(3,3),vertices(3,5),x,vertex_color(3,1:3),vertex_color(1,1:3),1);
                end
            elseif i~=3
                if vertices(i,1)<vertices(i+1,1)
                    cm = vector_interp(vertices(i,3),vertices(i,5),x,vertex_color(i,1:3),vertex_color(i+1,1:3),1);
                elseif vertices(i+1,1)<vertices(i,1)
                    cm = vector_interp(vertices(i,3),vertices(i,5),x,vertex_color(i+1,1:3),vertex_color(i,1:3),1);
                end
            end
            Y(ymin,x,1)=cm(1,1);
            Y(ymin,x,2)=cm(1,2);
            Y(ymin,x,3)=cm(1,3);
            c=1;
            oriz_pl = i;
            %color the pixels if the edge is horizontal and y=ymin
        end
    end
end
    
if c~=1
    if vertices(list_akm(1,1),3) == vertices(list_akm(2,1),3)
        list_shm(1,1) = vertices(list_akm(1,1),3);
    elseif vertices(list_akm(1,1),5) == vertices(list_akm(2,1),3)
        list_shm(1,1) = vertices(list_akm(1,1),5);
    elseif vertices(list_akm(1,1),3) == vertices(list_akm(2,1),5)
        list_shm(1,1) = vertices(list_akm(1,1),3);
    elseif vertices(list_akm(1,1),5) == vertices(list_akm(2,1),5)
        list_shm(1,1) = vertices(list_akm(1,1),5);
    end
    list_shm(2,1) = list_shm(1,1);
end
%find the active points
  
if c==1
    list_shm(1,1) = vertices(oriz_pl, 3);
    list_shm(2,1) = vertices(oriz_pl, 5);
    ymin=ymin+1;
end
%find the active poits if the edge is horizontal
 
for y=ymin:1:ymax
    if list_akm(1)==1 && list_akm(2)==2
        ck=vector_interp(vertices(2,2),vertices(1,2),y,vertex_color(2,1:3),vertex_color(1,1:3),2);
        cl=vector_interp(vertices(2,2),vertices(3,2),y,vertex_color(2,1:3),vertex_color(3,1:3),2);
    elseif list_akm(1)==2 && list_akm(2)==1
        ck=vector_interp(vertices(2,2),vertices(3,2),y,vertex_color(2,1:3),vertex_color(3,1:3),2);
        cl=vector_interp(vertices(2,2),vertices(1,2),y,vertex_color(2,1:3),vertex_color(1,1:3),2);
    elseif list_akm(1)==2 && list_akm(2)==3
        ck=vector_interp(vertices(3,2),vertices(2,2),y,vertex_color(3,1:3),vertex_color(2,1:3),2);
        cl=vector_interp(vertices(3,2),vertices(1,2),y,vertex_color(3,1:3),vertex_color(1,1:3),2);
    elseif list_akm(1)==3 && list_akm(2)==2
        ck=vector_interp(vertices(3,2),vertices(1,2),y,vertex_color(3,1:3),vertex_color(1,1:3),2);
        cl=vector_interp(vertices(3,2),vertices(2,2),y,vertex_color(3,1:3),vertex_color(2,1:3),2);
    elseif list_akm(1)==3 && list_akm(2)==1
        ck=vector_interp(vertices(1,2),vertices(3,2),y,vertex_color(1,1:3),vertex_color(3,1:3),2);
        cl=vector_interp(vertices(1,2),vertices(2,2),y,vertex_color(1,1:3),vertex_color(2,1:3),2);
    elseif list_akm(1)==1 && list_akm(2)==3
        ck=vector_interp(vertices(1,2),vertices(2,2),y,vertex_color(1,1:3),vertex_color(2,1:3),2);
        cl=vector_interp(vertices(1,2),vertices(3,2),y,vertex_color(1,1:3),vertex_color(3,1:3),2);
    end
    %calculate ck, cl
      
    x1=min(list_shm(:,1));
    x2=max(list_shm(:,1));
    %put the active points from the lower to higher value
 
    for x= floor(x1):1: (floor(x2)-1)
        cm = vector_interp((list_shm(1,1)),(list_shm(2,1)),x,ck,cl,1);
        Y(y,x,1)=cm(1,1);
        Y(y,x,2)=cm(1,2);
        Y(y,x,3)=cm(1,3);
    end
    %color the pixels
     
    if y==ymax
        break;
    end
    %break the loop if y=ymax
    
    for i=1:3        
        if y==vertices(i, 4)
            for z=1:2
                if vertices(list_akm(z,1), 6)==y
                    list_akm(z,1)=i;
                end
            end
        end
    end
    %update the list of the active edges
    
    if vertices(list_akm(1,1),7) ~= 0
        list_shm(1,1) = (list_shm(1,1) + (1/vertices(list_akm(1,1),7)));
    end
    if vertices(list_akm(2,1),7) ~= 0
        list_shm(2,1) = (list_shm(2,1) + (1/vertices(list_akm(2,1),7)));
    end
    %update the list of the active points
end

end
function [Img] = render(vertices_2d,faces,vertex_colors,depth,renderer)

I=1200*1200*3;
for x=1:1:1200
    for y=1:1:1200
        I(x,y,1)=1;
        I(x,y,2)=1;
        I(x,y,3)=1;
    end
end
%coloring the white array for the backround

depth2 = 25504*2;
for i=1:1:length(faces)
    depth2(i,2)=i;
    depth2(i,1)=(depth(faces(i,1))+depth(faces(i,2))+depth(faces(i,3)))/3;
end
%add the triangles from higher to lower depth to the array depth2
depth2=flip(sortrows(depth2));

for tri=1:25504
    if renderer=="Flat"
        I=paint_triangle_flat(I,vertices_2d(faces(depth2(tri,2),1:3),1:2),vertex_colors(faces(depth2(tri,2),1:3),1:3));
    end
    if renderer=="Gouraud"
        I=paint_triangle_gouraud(I,vertices_2d(faces(depth2(tri,2),1:3),1:2),vertex_colors(faces(depth2(tri,2),1:3),1:3));
    end
end
Img=I;
end
%This function draws the object.
function [I] = render_object(p,F,C,M,N,H,W,w,cv,clookat,cup)

%transfare the object to the camera's system
[P,D]=project_cam_ku(w,cv,clookat,cup,p);

%rasterize the system
Prast=rasterize(P,M,N,H,W);
%invert the array Prast
Prast=Prast';

%draw the object
renderer="Gouraud";
[I] = render(Prast,F,C,D,renderer);

end


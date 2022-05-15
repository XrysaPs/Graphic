%This class generates the transformation matrix
classdef transformation_matrix
    properties
        T=4*4;
    end
    
    methods
        %Constructor of the class
        function obj = transformation_matrix()
            %generating a 4x4 unit matrix
            obj.T = ones(4);
        end
        
        %generate the transformation matrix for the rotation of the object 
        function R = rotate(obj, theta, g)
            R = [(1-cos(theta))*g(1)^2+cos(theta)  (1-cos(theta))*g(1)*g(2)-sin(theta)*g(3)   (1-cos(theta))*g(1)*g(3)+(sin(theta))*g(2)   0
                (1-cos(theta))*g(2)*g(1)+(sin(theta))*g(3)   (1-cos(theta))*g(2)^2 + (cos(theta))   (1-cos(theta))*g(2)*g(3)-(sin(theta))*g(1)   0
                (1-cos(theta))*g(3)*g(1)-(sin(theta))*g(2)   (1-cos(theta))*g(3)*g(2)+(sin(theta))*g(1)   (1-cos(theta))*g(3)^2+(cos(theta))   0
                0   0   0   1];
        end
        
        %generate the transformation matrix for the displacement of the object
        function [T]=translate(obj, t)
            T = [1 0 0 t(1); 0 1 0 t(2); 0 0 1 t(3); 0 0 0 1];
        end
    end
end


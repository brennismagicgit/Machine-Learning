function [ dist ] = d( x,y )
%calculates squared distance between two 3D points
dist = norm((x-y).^2);
end


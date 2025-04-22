%%
%STREAMLINES AND WIND OVER USA
%Load the MATLAB data and determine minimum and maximum values to locate the slice planes and contour plots (load, min, max).
load wind
xmin = min(x(:));
xmax = max(x(:));
ymax = max(y(:));
zmin = min(z(:));

%Add Slice Planes for Visual Context
% Compute the wind speed
wind_speed = sqrt(u.^2 + v.^2 + w.^2);
figure 

hsurfaces = slice(x,y,z,wind_speed,[xmin,111,xmax],ymax,zmin);
set(hsurfaces,'FaceColor','interp','EdgeColor','none')
colormap turbo
%Define the Starting Points for Stream Lines

[sx,sy,sz] = meshgrid(80,20:10:50,0:5:15);
hlines = streamline(x,y,z,u,v,w,sx,sy,sz);
set(hlines,'LineWidth',2,'Color','r')

%Define the View
view(3)
daspect([2,2,1])
axis tight
box on;


%% https://au.mathworks.com/matlabcentral/fileexchange/35250-matlab-plot-gallery-wind
% Compute speed
spd = sqrt(u.*u + v.*v + w.*w);
figure

% Create isosurface patch
p = patch(isosurface(x, y, z, spd, 40));
isonormals(x, y, z, spd, p)
set(p, 'FaceColor', 'red', 'EdgeColor', 'none')
% Create isosurface end-caps
p2 = patch(isocaps(x, y, z, spd, 40));
set(p2, 'FaceColor', 'interp', 'EdgeColor', 'none')
% Adjust aspect ratio
daspect([1 1 1])
% Downsample patch
[f, verts] = reducepatch(isosurface(x, y, z, spd, 30), .2);
% Create coneplot (velocity cone)
h = coneplot(x, y, z, u, v, w, verts(:, 1), verts(:, 2), verts(:, 3), 2);
set(h, 'FaceColor', 'cyan', 'EdgeColor', 'none')
% Create streamline
[sx, sy, sz] = meshgrid(80, 20:10:50, 0:5:15);
h2 = streamline(x, y, z, u, v, w, sx, sy, sz);
set(h2, 'Color', [.4 1 .4])
% Adjust colormap and axes settings
colormap(jet)
box on
axis tight
camproj perspective
camva(34)
campos([165 -20 65])
camtarget([100 40 -5])
camlight left
lighting gouraud

%%
%Use the streamtube function to indicate flow in the wind data set. The inputs include the coordinates, vector field components, and starting location for the stream tubes.
load wind
[sx,sy,sz] = meshgrid(80,20:10:50,0:5:15);
streamtube(x,y,z,u,v,w,sx,sy,sz);
view(3);
axis tight
shading interp;
camlight; 
lighting gouraud

%fig2plotly()

%%
%Use vertex data returned by the stream3 function and divergence data to visualize flow.
load wind
[sx,sy,sz] = meshgrid(80,20:10:50,0:5:15);
verts = stream3(x,y,z,u,v,w,sx,sy,sz);
div = divergence(x,y,z,u,v,w);
streamtube(verts,x,y,z,-div);
view(3);
axis tight
shading interp
camlight 
lighting gouraud

%fig2plotly()

%%
%Try running the code below. It plots all streamlines, then loops through each streamline asking, "does this streamline's x data pass through 85 and 130?" If yes, it changes the streamlines to red.

load wind
[sx,sy,sz] = meshgrid(80,20:10:50,0:5:15);
h = streamline(x,y,z,u,v,w,sx,sy,sz);
view(3) 
xlabel('x direction') 
ylabel('y direction') 
% preallocate an array of streamline indices that we'll later deem
% interesting:
ind = zeros(size(h));
for k = 1:length(h); % essentially, for each stream line.
    xk = get(h(k),'xdata'); % get its x data
    if min(xk)<=85 & max(xk)>=130; 
        ind(k)=1; 
    end    
end
% set qualifying streamlines to red.
set(h(logical(ind)),'color','red')


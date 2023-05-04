files = dir('*.xlsx') ;
files = natsortfiles(files) ;
N = length(files) ;

% Custom pixel/mm ratio list for Metamoeba leningradensis chemotaxis

ratio_list = {...
    {23.44,23.44,23.44,23.44,23.44,23.44,23.44},...
    {11.63,11.63,11.63,11.63,11.63,11.63,11.63,11.63},...
    {23.44,23.44,23.44,23.44,23.44,23.44,23.44},...
    {23.44,23.44,23.44,23.44,23.44},...
    {23.44,23.44},...
    {23.44,23.44,23.44,23.44,23.44,23.44,23.44},...
    {11.63,11.63,11.63,11.63},...
    {23.44,23.44,23.44},...
    {11.63,11.63,11.63,11.63,11.63,11.63,11.63},...
    {23.44,23.44},...
    {38.7651,38.7651,38.7651,38.7651,38.7651,38.7651,38.7651},...
    {38.7651,38.7651,38.7651,38.7651,38.7651},...
    {38.7651,38.7651,38.7651,38.7651,38.7651,38.7651,38.7651}
    } ;

for i = length(ratio_list)
    figure('Name',strcat('Tracks_group_',i))
    hTracks = gca;
    [ratio_list{:}]
    
    for j = length(ratio_list{i})
        
        thisfile = files(i).name ;
        temp_x = readmatrix(thisfile,'Range','E1:E3600') ;
        temp_y = readmatrix(thisfile,'Range','F1:F3600') ;
            
        % center
        centered_x = temp_x-temp_x(1) ;
        centered_y = temp_y-temp_y(1) ;
        
        % convert to polar coordinates
    %     [teta,rho] = cart2pol(centered_x,centered_y);
    %     rho = rho/11.63;
        
        % scale
        scaled_x = centered_x/ratio_list(i);
        scaled_y = centered_y/ratio_list(i);
        
        % Plot trajectory and 'ko' marker at its tip
        disp(i)
        plot(hTracks, scaled_x, scaled_y, 'Color', [0, 0, 0]) ;
        hold on;
        plot(hTracks, scaled_x(end), scaled_y(end), 'ko',  'MarkerFaceColor',  [0, 0, 0], 'MarkerSize', 2) ;
    end
end

%Adjust proportions of 'tracks' figure after each condition   
divx=[-18 18];
divy=[0 0];
plot(hTracks,divx,divy,'k');
hold on;
plot(hTracks,divy,divx,'k');
hold on;
axis([-18 18 -18 18]);
daspect([1 1 1]);
box on;
hold off
% [name0,name2,name3]=fileparts(pwd) ;
% [~,name1] = fileparts(name0) ;
% filename = strcat(name1, 32, name2, name3, '.mat') ;
% clear name0 name1 name2 name3 temp_y temp_x files thisfile N i
% save(filename) ;
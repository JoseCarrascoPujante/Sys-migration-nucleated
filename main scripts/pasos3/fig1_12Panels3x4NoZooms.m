function figure1 = fig1_12Panels3x4NoZooms(coordinates, destination_folder)

field_names = {
    'SinEstimuloProteus11_63';
    'GalvanotaxisProteus11_63';
    'QuimiotaxisProteus11_63';
    'InduccionProteus11_63';
    'SinEstimuloLeningradensis11_63';
    'GalvanotaxisLeningradensis11_63'    ;
    'QuimiotaxisLeningradensisVariosPpmm';
    'InduccionLeningradensis11_63';
    'SinEstimuloBorokensis23_44';
    'GalvanotaxisBorokensis11_63';
    'QuimiotaxisBorokensis23_44';
    'InduccionBorokensis11_63'               
    };
figure('Position', [10 10 800 600])
figure1 = tiledlayout(3,4,'TileSpacing','tight','Padding','tight') ; % outer layout

%# Panels 1-4
for i = 1:length(field_names)
    ax = nexttile;
    box on
    ax.LineWidth = .4;
    hold on
    if i < 4
        colr = 'k';
    elseif (i > 4) && (i <= 8)
        colr = 'r';
    elseif i > 8
        colr = 'b';
    end
    for track = 1:length(coordinates.(field_names{i}).scaled_x(1,:))
        %# Plot trajectory and 'ko' marker at its tip
        plot(coordinates.(field_names{i}).scaled_x(:,track),...
            coordinates.(field_names{i}).scaled_y(:,track), 'Color',colr);
        plot(coordinates.(field_names{i}).scaled_x(end,track),...
            coordinates.(field_names{i}).scaled_y(end,track),'o','MarkerFaceColor', ...
            colr,'MarkerEdgeColor',colr,'MarkerSize',1.5) ;
    end
    ax.FontSize = 7;
    MaxX = max(abs(ax.XLim))+1;   MaxY = max(abs(ax.YLim))+1;
    xline(0,'-','Alpha',1,'Color',[0 0 0]); % xline and yline cannot be sent to plot back
    yline(0,'-','Alpha',1,'Color',[0 0 0]);
    axis equal
    if MaxX > MaxY
        axis([-MaxX MaxX -MaxY*(MaxX/MaxY) MaxY*(MaxX/MaxY)]);
    elseif MaxY > MaxX
        axis([-MaxX*(MaxY/MaxX) MaxX*(MaxY/MaxX) -MaxY MaxY]);
    elseif MaxY == MaxX
        axis([-MaxX MaxX -MaxY MaxY]);
    end
end

% Export as .jpg and .svg
versions = dir(destination_folder) ;
gabs = 1 ;
for v = 1:length(versions)
    if  contains(versions(v).name, 'Fig1_3x4')
        gabs = gabs + 1 ;
    end
end

disp(strcat(num2str(gabs),' Fig1_3x4 files found'))

exportgraphics(gcf,strcat(destination_folder, '\Fig1_3x4(',num2str(gabs),').jpg') ...
    ,"Resolution",400)
exportgraphics(gcf,strcat(destination_folder, '\Fig1_3x4(',num2str(gabs),').tiff') ...
    ,"Resolution",400)
exportgraphics(gcf,strcat(destination_folder, '\Fig1_3x4(',num2str(gabs),').pdf') ...
    ,'BackgroundColor','white', 'ContentType','vector')

end
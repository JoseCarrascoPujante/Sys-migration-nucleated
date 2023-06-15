% Figure 2
%% Layouts
fig = figure('Position',[350 10 750 950]);
layout0 = tiledlayout(3,1,'TileSpacing','tight','Padding','tight') ;
layout1 = tiledlayout(layout0,1,3,'TileSpacing','tight','Padding','tight') ;
layout1.Layout.Tile = 1;
layout2 = tiledlayout(layout0,3,1,'TileSpacing','tight','Padding','tight') ;
layout2.Layout.Tile = 2;

%% Panel 1 - RMSF max_correlation
fields = {"InduccionProteus11_63","InduccionLeningradensis11_63","QuimiotaxisBorokensis23_44"};
amoebas = {8,55,44};
for i=1:3 % subpanels (species)
    nexttile(layout1)   
    rmsfhandle = gca;
    set(rmsfhandle,'xscale','log')
    set(rmsfhandle,'yscale','log')
    amebas5(coordinates.(fields{i}).scaled_rho(:,amoebas{i}),rmsfhandle) ;
end

%% Panel 2 - RMSF \alpha
field_names = fieldnames(results) ;
species = {'Proteus','Leningradensis','Borokensis'};

for i=1:length(species) % subpanels (species)
    nexttile(layout2);
    t = gca;
    hold on
    for f = find(contains(field_names(:),species(i)))' % condition indexes
        exes = zeros(size(results.(field_names{f}),1));
        plot(results.(field_names{f})(:,1),exes,'ro','MarkerSize',6)
    end
    ylim([0 eps])
    t.YAxis.Visible = 'off'; % remove y-axis
    t.Color = 'None';
    hold off
end

%% Panel 3 - RMSF Violin plots
ax=nexttile(layout0,3);
conditions = {'SinEstimulo','Galvanotaxis','Quimiotaxis','Induccion'};
rmsfs = {[],[],[],[]};
for i=1:length(conditions) % subpanels (conditions)    
    for f = find(contains(field_names(:),conditions(i)))' % condition indexes
        rmsfs{i} = [rmsfs{i}; results.(field_names{f})(:,1)];
    end
end
rmsfs_pad = padcat(rmsfs{1},rmsfs{2},rmsfs{3},rmsfs{4});
hold on
%%%Simple violin plots
% violin(rmsfs,'xlabel',...
% {'\itSin estímulo','\itGalvanotaxis','\itQuimiotaxis','\itInduccion'}, ...
%     'ylabel',{'RMSF\alpha'},'FontSize',4,'facecolor',...
%     [[0,0,0];[1,0,0];[0,0,1];[0,1,0]],'facealpha',0.15,'mc','y','medc','r')
% boxplot(rmsfs_pad)

%%%More elaborate violin plots
% violinplot(rmsfs_pad,...
%     {'\itSin estímulo','\itGalvanotaxis','\itQuimiotaxis','\itInducción'}, ...
%     'ViolinColor',[0,0,0;1,0,0;0,1,0;0,0,1],'ViolinAlpha',0.15,'ShowData',...
%     false,'ShowNotches',false,'ShowMean',true,'ShowMedian',true,'MedianColor',...
%     [1 1 0],'HalfViolin','left','BoxColor',[0 0 0],'BoxWidth',0.02)
% boxplot(rmsfs_pad)


%%%"Superviolin" plots
% rmsf_conds = {{[],[],[]},{[],[],[]},{[],[],[]},{[],[],[]}};
% for i=1:length(conditions) % main boxes (conditions)
%     f = find(contains(field_names(:),conditions(i)))'; % condition indexes
%     for j = 1:length(f) % secondary boxes (species)
%         rmsf_conds{i}{j} = results.(field_names{f(j)})(:,1);
%     end
% end
% for i=1:length(conditions) % main boxes (conditions)
%     superviolin(rmsf_conds{i},'Parent',ax,'Xposition',i,'FaceAlpha',0.15,...
%         'Errorbars','ci','LUT',[[0,0,1];[0,0,0];[1,0,0]],'LineWidth',0.1)
% end
% colorgroups = [repmat({'Amoeba borokensis'},length(rmsf_conds{1}{1}),1);
%     repmat({'Amoeba proteus'},length(rmsf_conds{1}{2}),1);
%     repmat({'Metamoeba leningradensis'},length(rmsf_conds{1}{3}),1);
%     repmat({'Amoeba borokensis'},length(rmsf_conds{2}{1}),1);
%     repmat({'Amoeba proteus'},length(rmsf_conds{2}{2}),1);
%     repmat({'Metamoeba leningradensis'},length(rmsf_conds{2}{3}),1);
%     repmat({'Amoeba borokensis'},length(rmsf_conds{3}{1}),1);
%     repmat({'Amoeba proteus'},length(rmsf_conds{3}{2}),1);
%     repmat({'Metamoeba leningradensis'},length(rmsf_conds{3}{3}),1);
%     repmat({'Amoeba borokensis'},length(rmsf_conds{4}{1}),1);
%     repmat({'Amoeba proteus'},length(rmsf_conds{4}{2}),1);
%     repmat({'Metamoeba leningradensis'},length(rmsf_conds{4}{3}),1)];
% 
% boxChart_rmsf=cat(1,rmsfs{1},rmsfs{2},rmsfs{3},rmsfs{4});
% boxchart([ones(length(rmsfs{1}),1); repmat(2,length(rmsfs{2}),1); ...
%     repmat(3,length(rmsfs{3}),1); repmat(4,length(rmsfs{4}),1)],boxChart_rmsf,...
%     'GroupByColor',colorgroups)
% colororder([0,0,1;0,0,0;1,0,0]); 

%%%RainCloud plot


h=gca;
h.XTick = [1 2 3 4];
xticklabels(conditions)
h.XAxis.TickLength = [0 0];
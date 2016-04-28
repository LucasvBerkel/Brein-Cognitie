%% BREIN EN COGNITIE 2016 KI COMPUTERPRACTICUM
% GERT-JAN MUNNEKE, UNIVERSITEIT VAN AMSTERDAM

% INHOUD:
% 1) Het filteren van EEG Data
% 2) Het berekenen van event related potentials (ERP's)
% 3) Resultaten visualiseren in topoplots

% OPDRACHT:
% Doorloop en run het script blok voor blok. Soms zal je gevraagd worden om
% ontbrekende delen in de code zelf aan te vullen. Terwijl je door het
% script heen loopt zal je ook vragen tegenkomen die aangegeven worden met
% *Q*. Deze vragen moet je beantwoorden en uiteindelijk toevoegen aan je
% LateX verslag.

% Herkomst data:
% De data die we gebruiken komt uit een experiment naar de mening van
% mensen over het schenden van copyright. Het schenden van copyright door
% bijv. een speelfilm te downloaden is illegaal maar veel mensen vinden het
% niet erg als men het doet. Om te kijken hoe snel het brein een moreel
% oordeel hierover kan vormen is EEG gebruikt. Proefpersonen zagen zinnen
% die woord voor woord op het computerscherm werden getoond. Een
% voorbeeldzin:
% Conditie 1: "IK VIND COPYRIGHT-SCHENDING ACCEPTABEL"
% Conditie 2: "IK VIND COPYRIGHT-SCHENDING ONACCEPTABEL"
% Het laatste woord in de zin wordt het kritieke woord genoemd. Als men het
% oneens is met een dergelijke zin zal ten tijde van dit kritieke woord een
% bepaald ERP component ontstaan. Om die zichtbaar te maken dienen we een
% aantal analysestappen te nemen.

%% Eerst hebben we data nodig (zorg er voor dat het bestand in je working 
% directory staat:
load sampleEEGdata.mat

EEG % laat de inhoud van onze datastructuur zien in de command window

% Bestudeer de velden in de datastructuur 'EEG' en beantwoord adh hiervan
% de volgende vragen:
% *Q*: Geef de dimensies van het EEG dataveld 'EEG.data' (in getallen).
% *Q*: Wat stellen deze dimensies voor? (leg uit in woorden) 

%% Electrode-lokaties:
% De verschillende electrodes die worden gebruikt worden aangegeven met
% afkortingen die hun locatie aangeven. Om deze te zien kan je de functie
% topoplot gebruiken: 
% Opdracht: In de volgende code ontbreekt de informatie voor de
% kanaallocaties. Voeg deze datastructuur in op de plek waar ***** staat.
% Tip: de kanaallocaties staan ergens in de EEG datastructuur.

figure
topoplot([], EEG.chanlocs ,'electrodes','ptslabels');

%% Om te zien hoe de data eruit ziet gaan we een aantal trials plotten.
% Opdracht: Vervang de twee instanties van xxxxx in de code hieronder met
% 1) een kanaal die je graag wilt plotten (maakt niet uit welke) en 2) geef
% aan hoeveel trials je wilt plotten (maakt niet uit hoeveel, zolang het
% maar een beetje goed zichtbaar blijft). Experimenteer met deze
% instellingen en vergelijk verschillende kanalen.
% *Q*: Maak 36 plots van kanaal 'fcz' en sla de resulterende figuur op als
% pdf zodat je deze laten toe kan voegen aan je LateX verslag.

which_channel_to_plot = 'fcz';
channel_index = strcmpi(which_channel_to_plot,{EEG.chanlocs.labels});
x_axis_limit = [-300 300]; % Tijd in ms

num_trials2plot = 36 % aantal trials die we willen plotten

figure
set(gcf,'Name',[ num2str(num_trials2plot) ' random trials from channel ' which_channel_to_plot ])
for i=1:num_trials2plot
    
    % We bepalen hoeveel plots we horizontaal en verticaal willen plotten
    subplot(ceil(num_trials2plot/ceil(sqrt(num_trials2plot))),ceil(sqrt(num_trials2plot)),i)
    
    % We pakken een random trial
    random_trial_to_plot = randsample(EEG.trials,1);
    
    % En we plotten deze random trial
    plot(EEG.times,squeeze(EEG.data(channel_index,:,random_trial_to_plot)));
    set(gca,'xlim',x_axis_limit,'ytick',[])
    title([ 'Trial ' num2str(random_trial_to_plot) '.' ])
end

%% Nu gaan we de data filteren
% Zoals je net hebt kunnen zien heeft EEG data nogal wat ruis. 
% Een deel van dit ruis kunnen we eruit filteren
% adhv een Fourier transformatie. Er zijn veel keuzes die hierin gemaakt
% kunnen worden afhankelijk van welke frequenties je precies eruit wilt
% filteren. Hieronder zullen we verschillende filters toepassen en de
% resultaten Vergelijken:

% Het filteren zullen we demonstreren voor voor 1 electrode.
dat4filter=double(squeeze(EEG.data(47,:,1)));
% in de code zien we dat dit electrode 47 is
% *Q*: Wat is de naam van deze electrode en waar bevindt die zich?
% Tip: gebruik de datastructuur en de topoplot die we net voor de 
% kanaallocaties hebben gebruikt.

%% filteren:
% low-pass filter op 20 Hz
lowpass = eegfiltfft(dat4filter,EEG.srate,0,20);

% high-pass filter op 20 Hz
highpass = eegfiltfft(dat4filter,EEG.srate,20,0);

% band-pass filter to isolate 10-20 hz oscillations
bandpass = eegfiltfft(dat4filter,EEG.srate,10,20,length(dat4filter),[],0);

% plot en vergelijk de resultaten van de verschillende filters:
figure, set(gcf,'Name','Comparison of high, low, and bandpass filters')
plot(EEG.times,dat4filter,'k','linew',2)
hold on
plot(EEG.times,lowpass,'r')
plot(EEG.times,highpass,'g')
plot(EEG.times,bandpass,'m')

legend({'original';'lowpass (0-20 Hz)';'highpass (20-NF Hz)';'bandpass (10-20 Hz)'})

%*Q*: Welk van deze filters is het beste om uiteindelijk ERP's te berekenen?
% Tip: Deze informatie kan je opzoeken maar je kan ook kijken naar welk
% resultaat het meest op een typische ERP lijkt.

%% ERP's berekenen:
% Ons filter heeft ruis uit bepaalde frequenties eruitgehaald. Er blijft
% echter nog wat ruis over zoals de ruis tussen trials. Dit kunnen we eruit
% filteren door ERP's te berekenen. ERP's zijn het resultaat van het 
% gemiddelde over trials. Dit zorgt er voor dat ruis tussen trials 
% elkaar opheft. 

which_channel_to_plot = 'fcz'; % we zullen electrode fcz gebruiken
channel_index = strcmpi(which_channel_to_plot,{EEG.chanlocs.labels});

figure
erp = squeeze(mean(EEG.data(channel_index,:,:),3)); % De 3 betekend dat we middelen over de 3e dimensie, namelijk trials

% Plot de ERP. Merk op dat de ERP slechts een gemiddelde is:
plot(EEG.times,erp) 

% plot lijnen voor de baseline activiteit en de stimulus onset
hold on
plot(get(gca,'xlim'),[0 0],'k')
plot([0 0],get(gca,'ylim'),'k:')

% voeg labels en titel toe
xlabel('Time (ms)')
ylabel('\muV') % note that matlab interprets "\mu" as the Greek character for micro
title([ 'ERP (average of ' num2str(EEG.trials) ' trials) from electrode ' EEG.chanlocs(channel_index).labels ])

% plot de positieve en negatieve as ondersteboven zoals gebruikelijk is bij
% EEG studies. Vraag me niet waarom, ik heb werkelijk geen idee :-)
set(gca,'ydir','reverse')

% Pas de x-axis label aan
set(gca,'xlim',[-200 1000])
xticklabel=cellstr(get(gca,'xticklabel'));
xticklabel{str2double(xticklabel)==0}='stim';
set(gca,'xticklabel',xticklabel)

% Het resultaat geeft een ERP en is inderdaad minder ruisig dan een trial.
% Maar als je goed hebt gekeken naar de code zie je dat we een foutje
% hebben gemaakt, we hebben namelijk een ERP berekend op ongefilterde data.
% Laten we de ERP alsnog filteren:
erp_filtered = eegfiltfft(erp,EEG.srate,0,20); % is een 20 hz low pass filter

% *Q*: Kopier deze blok met code en vervang de ongefilterde data
% 'EEG.data' met de gefilterde erp. Sla de gefilterde en ongefilterde
% figuren op als pdf om ze later toe te voegen aan je LateX rapport.

%% Topoplot van resultaten
% EEG resultaten worden snel complex aangezien er veel dimensies zijn. 
% We kunnen namelijk een ERP berekenen
% per electrode en ook nog eens voor verschillende tijden afhankelijk van
% in welke ERP component we geinterreseerd zijn. Dit zijn heel veel plots
% om naar te kijken. Om het leven van een EEG onderzoeker makkelijker te
% maken kunnen we de resultaten in 1 keer visualiseren in een topoplot. Zo
% zien we in 1 opzicht wat de piekwaarden zijn per electrode. Als we een
% aantal tijdspunten kiezen en per tijdspunt een topoplot maken kunnen we
% zien hoe het brein over de tijd heen reageert op de stimulus.
% Onderstaande code doet dat voor ons.

times2plot = 0:100:800;

figure, set(gcf,'name','part 1');

clim = [-10 10];

for timei=1:length(times2plot)
    
    % convert time in ms to index
    [junk,timeidx] = min(abs(EEG.times-times2plot(timei)));
    
    % plot in flexibly appropriate subplot
    subplot(ceil(length(times2plot)/ceil(sqrt(length(times2plot)))),ceil(sqrt(length(times2plot))),timei)
    topoplot(squeeze(mean(EEG.data(:,timeidx,:),3)),EEG.chanlocs,'plotrad',.53,'maplimits',clim);
    title([ 'ERP at ' num2str(round(EEG.times(timeidx))) 'ms' ])
    
end

% *Q*: Tussen 301 en 398 is er activiteit rond 1 electrode. Welke electrode
% is dit? Gebruik de code van dit script om de ERP te plotten van dit
% kanaal. Deze ERP hoeft NIET gefilterd te zijn. Sla de figuur met de ERP op als
% pdf en voeg het toe aan je verslag.

%% Laatste opdracht:
% In de plots van FZc zagen we een Positieve piek na 200 ms, dit ERP
% component wordt daarom ook P200 genoemd. De piek uit jouw laatste plot
% was ook Positief en vond rond de 300 ms plaats, en wordt dus P300
% genoemd. De P200 is een indicatie dat men het geheugen activeert. De P300 is
% een indicatie dat men verasst is door wat men zag. Gebruik deze
% informatie om de volgende vraag te beantwoorden.

% *Q*: In welke conditie zat de proefpersoon? Ga er van uit dat de
% proefpersoon geen bezwaar heeft tegen copyrightschending.
% Gebruik in je uitleg de timing en betekenis van de ERP componenten alsmede
% de info over de herkomst van de data aan het begin van dit script.
% Speculeer op basis hiervan wat het brein aan het doen was na het zien 
% van het kritieke woord.









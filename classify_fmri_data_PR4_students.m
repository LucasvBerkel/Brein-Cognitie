%% Brein en cognitie 2016
%% PR4: Classificatie van fMRI data
%% Created by Jolien Francken 2016
%% Namen: Lucas van Berkel, Joël Meyer 
%% Studentnummers: 10747958, 10003539
%% Groep: 39

%% Introductie
%In dit practicum gaan we fMRI data gebruiken van een experiment waarbij proefpersonen bewegende stippen te zien kregen die op of neer bewogen. In
%deel 1 gaan we voor iedere proefpersoon de relevante data selecteren. In deel 2 creeeren we een training- en testset en gaan we de 
%classificatie uitvoeren om uiteindelijk onze hoofdvraag te beantwoorden:
%Kunnen we op basis van fMRI-patronen voorspellen of een proefpersoon naar opwaartse of neerwaartse beweging kijkt?
clear all; close all;
data_dir = 'C:\Users\Lucas\Documents\Uni\Brein-Cognitie'; %%%%%Geef hier de directory waar de datafile is opgeslagen
load(fullfile(data_dir,'data_struct'));
subjects = {'S02','S03','S04','S06','S07'}; %We gaan de data van 5 proefpersonen analyseren. Nummer S01 en S05 zijn geexcludeerd; S01 viel in slaap tijdens het experiment; S05 bewoog teveel tijdens het scannen zodat de data onbruikbaar werd.
rois = {'lOC','rOC'}; %We bekijken fMRI-patronen in twee 'regions of interest'(ROIs): de linker en rechter visuele cortex
vox_sel = [10 50 100 200 300 400 500]; %Aantal voxels binnen de ROIs die we willen includeren


%% Deel 1: dataselectie
%We hebben een aantal dingen nodig voor we kunnen beginnen met classificeren. 
%Ten eerste willen we voor iedere trial (20 per proefpersoon) de fMRI activatie oftewel 'beta waarde' voor een aantal voxels binnen onze ROIs. Daarvoor hebben we dus ook een 'mask' van zowel de linker als rechter visuele cortex nodig om te bepalen wat onze ROI is. 
%Ten tweede willen we voor iedere trial weten of er opwaartse of neerwaartse beweging werd getoond. 
%Al deze informatie is opgeslagen in de data_struct. Voor iedere proefpersoon vind je daar:
%1. subj                    = naam subject
%2. betas                   = beta waarde voor iedere voxel x iedere trial voor het contrast beweging > fixatie (een leeg scherm met een kruisje in het midden waar de proefpersoon op moet fixeren)
%3. trial_info.incl_trials  = de indices van de 20 (van de 70) trials waarin opwaartse of neerwaartse beweging getoond werd
%   trial_info.cond         = de conditie, oftewel een 1 voor opwaartse en een 2 voor neerwaartse beweging voor de 20 trials
%4. mask                    = informatie over de linker (1) en rechter (2) visuele cortex masks
%   mask().nvox             = totaal aantal voxels dat binnen de mask valt
%   mask().ind              = locatie-indices van voxels binnen de mask gesorteerd van hoogste naar laagste beta waarde
%   mask().val              = beta waarden voor de voxels binnen de mask gesorteerd van hoogste naar laagste beta waarde
%   mask().roi              = naam roi


%Vraag 1
%a. Hoeveel voxels zitten er in het brein van proefpersoon S06?
%%
betas = data(4).betas;
[height, width] = size(betas);
counter = 0;
for i=1:height
    if(isnan(betas(i,1)))
        counter = counter + 1;
    end
end
totalAmountOfVoxels = height - counter
%%
%b. Hoeveel voxels vallen er binnen de linker visuele cortex van S06? En hoeveel binnen de rechter?
%c. Wat is de locatie/index van de voxel met de hoogste beta waarde binnen de linker visuele cortex van S06? En wat is deze waarde?
%d. Wat is de laagste beta waarde binnen de linker visuele cortex van S06? Wat betekent dit denk je?
%e. Plot de beta waarden voor alle voxels van S06. Plaats deze plot ook in het verslag. Wat valt je op?
%%
figure;
hold on;
X1 = data(4).mask(1).val(1:data(4).mask(1).nvox);
X2 = data(4).mask(2).val(1:data(4).mask(2).nvox);
plot(X1)
plot(X2)
legend({'Left visual cortex' 'Right visual cortex'})
hold off;
%%
%We willen classificeren binnen de ROI en daarom gaan we nu de relevante voxels selecteren. Wat zijn de relevante voxels? Ten eerste natuurlijk de voxels die
%binnen de mask vallen. Ten tweede de meest actieve voxels binnen de mask, waarvan we het aantal kunnen varieren; de waarden die we nu gebruiken
%staan in de variabele vox_sel.

%We beginnen de classificatie met proefpersoon S02, in de linker visuele cortex, met 10 voxels
isubj = 1;
iroi = 1;
ivox = 1;
            
%Selecteer meest actieve voxels binnen de mask
nvox = min(vox_sel(ivox),data(isubj).mask(iroi).nvox);
max_indx = data(isubj).mask(iroi).ind(1:nvox); 
vectors = data(isubj).betas(max_indx,:)';     
%Excludeer voxels met waarde 0 of NaN
incl_voxels = find(std(vectors,0,1) ~= 0 & ~isnan(vectors(1,:)));
vectors = vectors(:,incl_voxels);             
vectors = zscore(vectors);     
%Selecteer data voor de 20 relevante trials (met opwaartse of neerwaartse beweging)
vectors = vectors(data(isubj).trial_info.incl_trials,:);

%Vraag 2
%a. Waarom selecteren we de voxels apart voor iedere proefpersoon? 
%b. Waarom willen we alleen de meest actieve voxels selecteren?


%% Deel 2: training- en testset
%Nu we de data hebben geselecteerd, kunnen we beginnen met de classificatie. Is het mogelijk om te voorspellen welke bewegingsrichting de proefpersoon bekeek op basis van de fMRI activatiepatronen in de visuele cortex?
%Hiervoor verdelen we de data in een trainingsset en een testset. We selecteren 10 keer 18 trials om op te trainen, en 2 om op te
%testen (cross-validation). Vervolgens worden de trainings fMRI patronen (vectors) en de trainings labels gebruikt om een lineaire SVM te
%trainen. Daarna krijgt de SVM de test vectors en bepaalt welk label daar het beste bij past (1 of 2, oftewel opwaartse of
%neerwaartse beweging). Deze labels worden opgeslagen in classification_labels.
[~, sizeSubjects] = size(subjects);
[~, sizeRois] = size(rois);
[~, sizeVox_sel] = size(vox_sel);
results = zeros(sizeRois*sizeSubjects, sizeVox_sel);
counter = 1;
for k=1:sizeSubjects
    for j=1:sizeRois
        for i=1:sizeVox_sel
            isubj = k;
            iroi = j;
            ivox = i;

            %Selecteer meest actieve voxels binnen de mask
            nvox = min(vox_sel(ivox),data(isubj).mask(iroi).nvox);
            max_indx = data(isubj).mask(iroi).ind(1:nvox); 
            vectors = data(isubj).betas(max_indx,:)';     
            %Excludeer voxels met waarde 0 of NaN
            incl_voxels = find(std(vectors,0,1) ~= 0 & ~isnan(vectors(1,:)));
            vectors = vectors(:,incl_voxels);             
            vectors = zscore(vectors);     
            %Selecteer data voor de 20 relevante trials (met opwaartse of neerwaartse beweging)
            vectors = vectors(data(isubj).trial_info.incl_trials,:);

            ntrials = 1:20;
            nblocks = 10;
            ntrials_per_block = 2;
            classification_labels = zeros(length(data(isubj).trial_info.cond),1);

            for iblock = 1:nblocks

                %Train op trials die niet iblock zijn
                train_indices_number = setdiff(1:length(ntrials),1+(iblock-1)*ntrials_per_block:iblock*ntrials_per_block);
                train_indices = ntrials(train_indices_number);
                train_vectors = vectors(train_indices,:);
                train_labels = data(isubj).trial_info.cond(train_indices);

                %Test op trials die iblock zijn
                test_indices_number = 1+(iblock-1)*ntrials_per_block:iblock*ntrials_per_block;
                test_indices = ntrials(test_indices_number);
                test_vectors = vectors(test_indices,:);
                test_labels = data(isubj).trial_info.cond(test_indices);

                %Train en test de SVM
                svmstruct = svmtrain(train_vectors,train_labels,'AutoScale',false);
                classification_labels(test_indices) = svmclassify(svmstruct,test_vectors);

                clear test* train* svmstruct 

            end

            %Bereken de accuracy van de SVM classificatie
            accuracy = sum(classification_labels(ntrials) == data(isubj).trial_info.cond(ntrials)')/length(ntrials);
            
            results(counter,i) = accuracy;
            
            clear classification_labels ntrials nblocks ntrials_per_block vectors max_indx incl_voxels iblock nvox
            clear iroi isubj ivox
        end

        if (mod(counter,2)==0)
            text = strcat('Right visual Cortex ',subjects(k));
        else
            text = strcat('Left visual Cortex ',subjects(k));
        end
        tempLegend(counter) = text;
        
        counter = counter + 1;

    end
end

figure;
hold on;
for i=1:sizeRois*sizeSubjects
    plot(vox_sel, results(i,:))
end
title('Accuracy of SVM classifier for left and right visual cortex')
legend(tempLegend)
ylabel('Accuracy')
xlabel('Number of voxels in trainingset')
axis([0 vox_sel(7) 0 1])
hold off;


%Vraag 3
%a. Leg uit hoe cross-validatie werkt (zie het artikel van Mur et al. (2009))
%b. Wat zijn support vectors? Hoeveel support vectors gebruikte de SVM voor de laatste classificatie (zie variabele svmstruct)?
%c. Waarom is het belangrijk dat trainings- en testset onafhankelijk zijn?
%d. Hoe wordt de accuracy van de SVM classificatie berekend? 
%e. Wanneer presteert de SVM op kansniveau? 
%f. Wat is het resultaat van deze classificatie? Wat is op basis hiervan het antwoord op onze hoofdvraag?

%Vraag 4
%a. Pas het script zodanig aan dat er geloopt wordt over het aantal voxels dat we selecteren binnen de ROI (vox_sel).
%b. Pas het script zodanig aan dat er nu ook nog geloopt wordt over de twee ROIs en plot de accuracy voor de twee ROIs en de verschillende waarden van vox_sel. Plaats deze plot ook in het verslag. 
%c. Kunnen we de bewegingsrichting beter decoderen in de linker of de rechter visuele cortex? Licht je antwoord toe.
%d. Wat verwacht je voor een resultaat als je de analyse uitvoert op een hersengebied buiten de visuele cortex?
%e. Pas het script zodanig aan dat er nu ook nog geloopt wordt over de proefpersonen. Bij welke proefpersoon werkt de classificatie het beste? En in welke ROI?
%f. Bereken de gemiddelde accuracy over proefpersonen en plot het gemiddelde, inclusief error bars, voor de twee ROIs en de verschillende waarden van vox_sel. Plaats deze plot ook in het verslag. 
%g. Waarom denk je dat de classificatie beter wordt naarmate er meer voxels worden geincludeerd?
%h. Wat is nu het resultaat van deze classificatie? Wat is op basis hiervan het antwoord op onze hoofdvraag?

%Vraag 5
%a. Denk je dat je opwaartse en neerwaartse beweging ook zou kunnen onderscheiden met een activation-based analysis (zie het artikel van Mur
%et al. (2009)? Licht je antwoord toe.
%b. Wat is het voordeel van het gebruik van een pattern-information analysis, zoals de analyse die we hier gebruikt hebben, boven een
%activation-based analysis?

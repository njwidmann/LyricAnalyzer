function compare_word_gui(unique_words, genres, percent_mat)
% This function creates a GUI for the user to enter a word and it displays
% a graph comparing the word's percentages across genres. Inputs are the
% unique_words cell array, the cell array of genres, and the percent_mat
% full of percentages for each word in each genre. percent_mat(j,k)
% corresponds to the percentage (with 0.5 = 50%) of unique_words{k} in
% genre{j}.

% create the GUI but make it invisible for now
f = figure('Visible', 'off', 'color', 'white', 'Position', [360, 500, 500, 400]);

% put a name on it and move it to the center of the screen
set(f, 'Name', 'Compare Word Percentages');
movegui(f, 'center');

% create two objects: a box where the user can type and edit a string and
% also a text title for the edit box
hsttext = uicontrol('Style', 'text',...
    'BackgroundColor', 'white',...
    'Position', [50, 225, 400, 55],...
    'String', 'Enter a word here to compare its percentage across genres');
huitext = uicontrol('Style', 'edit',...
    'Position', [50, 200, 400, 40],...
    'Callback', @callbackfn);

% Now the GUI is made visible
set(f, 'Visible', 'on');
 
    %Call back function
    function callbackfn(hObject,eventdata)
        % callbackfn is called by the 'Callback property in the editable
        % text box
         
        % get the string that the user entered
        word = get(huitext, 'String');
        
        word = upper(word);   %convert word entirely to uppercase
       
        %Go through each character in the word and remove all non-letters
        k = 1;
        while (k <= length(word))
            x = word(k); 
            if ~(x>='A' && x<='Z')  %if x is not a letter from A to Z
                word = strcat(word(1:k-1), word(k+1:end));  %cut the letter out of the word
            else
                k = k+1;
            end
        end
        
        % find the index of the word in unique words
        bools = strcmp(word, unique_words);
        ind = find(bools);
        
        % create an empty percentage vector
        percentages = zeros(1,length(genres));
        
        % if the word is in unique_words, add its percentages to
        % percentages
        if(~isempty(ind))
            for i = 1:length(genres)
                percentages(i) = percent_mat(i, ind);
            end
        end
        
        %create a new figure and plot the data
        figure
        bar(percentages);
        header = sprintf('Percentage of %s Across Genres', word);
        title(header);
        xlabel('Genre');
        ylabel('Percentage (0.5 = 50%)');
        set(gca, 'XTick', 1:length(genres), 'XTickLabel', genres); %label each bar with the genre

    end %end callbackfn
end
    
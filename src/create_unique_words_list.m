function unique_words = create_unique_words_list(all_words)
%This function takes a cell array of words and returns a cell array of all
%the unique words in the list
    unique_words = cell(1, length(all_words)); %create a new empty cell array
    all_words_copy = all_words; %make a copy of inputted all_words
    i = 1; %i corresponds to the index in unique_words
    while(~isempty(all_words_copy))  %Stop when all_words length = 0 
        word = all_words_copy{1}; %take the first word in the list = word
        unique_words{i} = word; %add the word to unique_words
        bools = strcmp(word, all_words_copy); %find and remove all the indeces of word in all_word
        indeces = find(bools);
        all_words_copy(indeces) = []; %remove all occurences of word from all_words. There is now a new word at index 1
        %fprintf('Creating Unique Words List... Words Completed: %d \t Words Left: %d\n', i, length(all_words_copy)); %print status
        i = i+1; %increment i
    end
    
    unique_words = unique_words(1:i-1); %Chop off all the empty cells
end
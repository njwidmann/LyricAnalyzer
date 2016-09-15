
function genre = find_genre(song_words_list, unique_words, percent_mat, genres)
%This function determines the genre of a given song. The unknown song is
%entered as a cell array. unique_words is entered a cell array. percent_mat
%is entered as matrix with rows corresponding to genres and cols
%corresponding to unique words. e.g. percent_mat(1,4) =
%the percentage of the fourth word in the first genre. Genres is entered as
%a cell array with the indexes corresponding to the rows in percent_mat

    song_percent_vec = zeros(1,length(unique_words)); %empty vec to hold the word percentages for the unknown song
    total_num_words = length(song_words_list);
    
    %tabulate percentages of each of unique_words in the unknown song
    for i = 1:length(unique_words)
        word = unique_words{i};
        word_bools = strcmp(word, song_words_list); %find and delete occurences of word in song
        indeces = find(word_bools);
        song_percent_vec(i) = length(indeces) / total_num_words; %put percentage in vec
        song_words_list(indeces) = [];
    end
    
    %We now loop through the genre percentages and find the shortest
    %distance to the unknown song
    min_distance = intmax; 
    closest_genre = 0;
    for i = 1:length(genres)
        genre_percent_vec = percent_mat(i,:);
        indeces = find(song_percent_vec);
        distance = norm(song_percent_vec(indeces) - genre_percent_vec(indeces));
        fprintf('Genre: %s \t Distance: %f\n', genres{i}, distance);
        if (distance < min_distance)
            min_distance = distance;
            closest_genre = i;
        end
    end
    
    genre = genres(closest_genre); %return determined genre


end
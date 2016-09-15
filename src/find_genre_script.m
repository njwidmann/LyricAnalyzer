%This script attempts to define a song's genre. song is given as variable
%filename. If filename is SONG_FILE, it is assumed that the file is at
%location 'unknown_songs/SONG_FILE.dat'

% filename = 'song5'; % AC/DC "Highway to Hell" - Rock
filename = 'song6'; % BRC "Only Time Will Tell" - Country (requires n=1000 filtering)

song_word_list = read_song_from_dat(filename);

song_word_list = filter_song(song_word_list, 1000); %filter out the n most popular words in the English language

genre = find_genre(song_word_list, unique_words, percent_mat, genres)
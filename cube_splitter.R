library(tidyverse)

# Split 540 cards into 8 sealed pools
num_groups <- 8
cube <- read_delim("sample_cube.txt", col_names = F, delim = "|")
num_cards <- nrow(cube)

# Create n groups of randomly shuffled cards. Each group has an equal number of cards which means some cards from the cube can be discarded.
groups <- cube %>% 
  sample_n(num_cards) %>% 
  slice_head(n = floor(num_cards/num_groups) * num_groups) %>% 
  group_by((row_number()-1) %/% (n()/num_groups)) %>%
  nest %>% 
  pull(data)

# Take the n groups of cards and write each to deckn.txt
Map(function(x, i) write_delim(x, paste0("deck",i,".txt"),delim = "|", col_names = F), groups, seq_along(groups))
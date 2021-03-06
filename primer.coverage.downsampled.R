primer.coverage.downsampled <- function(downsampled){
  require('tidyverse')
  require('vroom')
  
  range_join <- function(x, y, value, left, right){
    x_result <- tibble()
    for (y_ in split(y, 1:nrow(y)))
      x_result <-  x_result %>% bind_rows(x[x[[value]] >= y_[[left]] & x[[value]] < y_[[right]],] %>% cbind(y_))
    return(x_result)
  } # from this SO thread -- https://stackoverflow.com/questions/46795636/r-dplyr-join-by-range-or-virtual-column
  
  even.primer <- data.frame( accession = c("MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3"),
                             primername = c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98),
                             strand = c(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2),
                             left = c(320, 943, 1573, 2181, 2826, 3460, 4044, 4636, 5230, 5867, 6466, 7035, 7626, 8249, 8888, 9477, 10076, 10666, 11306, 11863, 12417, 13005, 13599, 14207, 14865, 15481, 16118, 16748, 17381, 17966, 18596, 19204, 19844, 20472, 21075, 21658, 22262, 22797, 23443, 24078, 24696, 25279, 25902, 26520, 27141, 27784, 28394, 28985, 29486),
                             right = c(726, 1337, 1964, 2592, 3210, 3853, 4450, 5017, 5644, 6272, 6873, 7415, 8019, 8661, 9271, 9858, 10459, 11074, 11693, 12256, 12802, 13400, 13984, 14601, 15246, 15886, 16510, 17152, 17761, 18348, 18979, 19616, 20255, 20890, 21455, 22038, 22650, 23214, 23847, 24467, 25076, 25673, 26315, 26913, 27533, 28172, 28779, 29378, 29866) ) 
  
  
  
  odd.primer <- data.frame( accession = c("MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3", "MN908947.3"),
                            primername = c(1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97),
                            strand = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
                            left = c(30, 642, 1242, 1868, 2504, 3144, 3771, 4294, 4939, 5563, 6167, 6718, 7305, 7943, 8595, 9204, 9784, 10362, 10999, 11555, 12110, 12710, 13307, 13918, 14545, 15171, 15827, 16416, 17065, 17674, 18253, 18896, 19548, 20172, 20786, 21357, 21961, 22516, 23122, 23789, 24391, 24978, 25601, 26197, 26835, 27446, 28081, 28677, 29288),
                            right = c(410, 1028, 1651, 2269, 2904, 3531, 4164, 4696, 5321, 5957, 6550, 7117, 7694, 8341, 8983, 9585, 10171, 10763, 11394, 11949, 12490, 13096, 13699, 14299, 14926, 15560, 16209, 16833, 17452, 18062, 18672, 19297, 19939, 20572, 21169, 21743, 22346, 22903, 23522, 24169, 24789, 25369, 25994, 26590, 27227, 27854, 28464, 29063, 29693) ) 
  
  
  even_df <- downsampled %>% 
    range_join(even.primer, "pos", "left", "right") %>% 
    group_by(sample_id, primername) %>% 
    summarise(mean_downsampled_depth = mean(downsampled_depth))
  
  odd_df <- downsampled %>% 
    range_join(odd.primer, "pos", "left", "right") %>% 
    group_by(sample_id, primername) %>% 
    summarise(mean_downsampled_depth = mean(downsampled_depth))
  
  merge_df <- bind_rows(even_df, odd_df) %>%
    arrange(sample_id, primername)
  
  return(merge_df)
  
  
}


# From https://stackoverflow.com/questions/26553638/calculate-elapsed-time-since-last-event#26554608

library(dplyr)

set.seed(12345)
id <- c(rep(1, 9), rep(2, 9), rep(3, 9))
time <- c(seq(from = 0, to = 96, by = 12),
          seq(from = 0, to = 80, by = 10),
          seq(from = 0, to = 112, by = 14))
random <- runif(n = 27)
event <- rep(100, 27)

df <- data.frame(cbind(id, time, event, random)) %>%   
  mutate(event = ifelse(random < 0.55, 0, ceiling(random*1000))) %>% 
  mutate(event = ifelse(time == 0, 0, event)) %>% 
  select(-random)
#df$event <- ifelse(df$random < 0.55, 0, df$event*ceiling(df$random*1000))
# df <- subset(df, select = -c(random))
# df$event <- ifelse(df$time == 0, 100, df$event)



df %>%
  mutate(tmp1 = (c(FALSE, (diff(event))))) %>% 
  mutate(tmp2 = cumsum(tmp1)) %>% 
  mutate(tmp3 = as.logical(tmp1)) %>%
  mutate(tmp4 = cumsum(tmp3)) %>% 
  mutate(tmpG = cumsum(c(FALSE, as.logical(diff(event))))) %>% 
  group_by(id) %>%
  mutate(tmp_a = c(0, diff(time)) * !event,
         tmp_b = c(diff(time), 0) * !event) %>%
  group_by(tmpG) %>%
  mutate(tae = cumsum(tmp_a),
         tbe = rev(cumsum(rev(tmp_b)))) #%>%
  ungroup() #%>%
  select(-c(tmp_a, tmp_b, tmpG))


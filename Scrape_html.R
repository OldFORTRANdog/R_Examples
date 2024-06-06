# From https://rvest.tidyverse.org/

# # The easiest way to get rvest is to install the whole tidyverse:
# install.packages("tidyverse")
# 
# # Alternatively, install just rvest:
# install.packages("rvest")

library(rvest)

# Start by reading a HTML page with read_html():
starwars <- read_html("https://rvest.tidyverse.org/articles/starwars.html")

# Then find elements that match a css selector or XPath expression
# using html_elements(). In this example, each <section> corresponds
# to a different film
films <- starwars %>% html_elements("section")
films

# Then use html_element() to extract one element per film. Here
# we the title is given by the text inside <h2>
title <- films %>% 
  html_element("h2") %>% 
  html_text2()
title

# Or use html_attr() to get data out of attributes. html_attr() always
# returns a string so we convert it to an integer using a readr function
episode <- films %>% 
  html_element("h2") %>% 
  html_attr("data-id") %>% 
  readr::parse_integer()
episode


####

html <- read_html("https://en.wikipedia.org/w/index.php?title=The_Lego_Movie&oldid=998422565")
 
html %>% 
  html_element(".tracklist") %>% 
  html_table()



# My testing

eBtrip <- read_html("https://ebird.org/tripreport/243361")
eBtrip %>% 
  html_element("*") 
?html_element

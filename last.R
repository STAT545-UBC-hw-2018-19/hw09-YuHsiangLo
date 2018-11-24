library(tidyverse)

words <- readLines("./data/words.txt")

lasts <- rep(0, length(letters))
names(lasts) <- letters

for (w in words) {
	last <- str_to_lower(str_sub(w, start = str_length(w), end = str_length(w)))
	lasts[last] <- lasts[last] + 1
}

df <- data.frame(letter = names(lasts), count = lasts)

p <- df %>%
	mutate(letter = fct_reorder(letter, count)) %>%
	ggplot(aes(x = letter, y = count)) +
	theme_bw() +
	geom_bar(stat = "identity") +
	labs(title = "Last Letters", x = "Letter", y = "Count") +
	theme(plot.title = element_text(hjust = 0.5)) +
	coord_flip()

ggsave(plot = p, filename = "./plots/last.png")
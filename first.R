library(tidyverse)

words <- readLines("./data/words.txt")

# Initialize a vector
firsts <- rep(0, length(letters))
names(firsts) <- letters

for (w in words) {
	first <- str_to_lower(str_sub(w, start = 1, end = 1))
	firsts[first] <- firsts[first] + 1
}

df <- data.frame(letter = names(firsts), count = firsts)

p <- df %>%
	mutate(letter = fct_reorder(letter, count)) %>%
	ggplot(aes(x = letter, y = count)) +
	theme_bw() +
	geom_bar(stat = "identity") +
	labs(title = "First Letters", x = "Letter", y = "Count") +
	theme(plot.title = element_text(hjust = 0.5)) +
	coord_flip()

ggsave(plot = p, filename = "./plots/first.png")
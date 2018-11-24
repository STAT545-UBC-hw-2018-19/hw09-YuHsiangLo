library(tidyverse)

words <- readLines("./data/words.txt")

common <- rep(0, length(letters))
names(common) <- letters

for (w in words) {
	for (i in 1:str_length(w)) {
		lttr <- str_to_lower(str_sub(w, start = i, end = i))
		if (lttr %in% letters) common[lttr] <- common[lttr] + 1
	}
}

df <- data.frame(letter = names(common), count = common)

p <- df %>%
	mutate(letter = fct_reorder(letter, count)) %>%
	ggplot(aes(x = letter, y = count)) +
	theme_bw() +
	geom_bar(stat = "identity") +
	labs(title = "Most Common Letters", x = "Letter", y = "Count") +
	theme(plot.title = element_text(hjust = 0.5)) +
	coord_flip()

ggsave(plot = p, filename = "./plots/common.png")
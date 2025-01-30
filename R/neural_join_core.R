neural_join <- function(model,a, b, by_a, by_b,
                        block_by_a = NULL, block_by_b = NULL,
                        radius = .1, exhaustive = FALSE, ...) {
    a_vec <- dplyr::pull(a, by_a)
    b_vec <- dplyr::pull(b, by_b)

    a_embeds <- generate_embeddings(model, a_vec, ...)
    b_embeds <- generate_embeddings(model, b_vec, ...)


    if (exhaustive) {
        match_table <- expand.grid(seq(length(a_vec)), seq(length(b_vec)))
    } else {
        match_table <- hnsw_join(a_embeds, b_embeds)
    }

    dist <- multi_cos_distance(a_embeds, b_embeds, match_table)

    within_dist <- dist < radius

    dist <- dist[within_dist]
    match_table <- match_table[within_dist, ]

    return(list(
                match_table = match_table,
                similarities = dist
                ))
}

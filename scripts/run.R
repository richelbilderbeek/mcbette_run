library(mcbette)
library(beautier)

if (can_run_mcbette()) {

  testit::assert(beastier::is_beast2_installed())
  testit::assert(mauricer::is_beast2_ns_pkg_installed())

  fasta_filename <- "my_alignment.fas"
  # mcbette will check if FASTA file exists

  # Create two inference models
  inference_model_1 <- create_inference_model(
    site_model = create_jc69_site_model(),
    mcmc = create_ns_mcmc(epsilon = 1e7)
  )
  inference_model_2 <- create_inference_model(
    site_model = create_hky_site_model(),
    mcmc = create_ns_mcmc(epsilon = 1e7)
  )
  inference_models <- list(inference_model_1, inference_model_2)

  df <- mcbette::est_marg_liks(
    fasta_filename = fasta_filename,
    inference_models = inference_models
  )

  # Show all models
  cat(" ", sep = "\n")
  cat("**********************************", sep = "\n")
  cat("* All models (ordered by index)  *", sep = "\n")
  cat("**********************************", sep = "\n")
  cat(" ", sep = "\n")
  knitr::kable(df)

  ################################################################################
  # Create an ordered data frame
  ################################################################################
  # Keep rows without an NA
  df_ordered <- na.omit(df)

  # Order from high to low
  df_ordered <- df_ordered[ order(-df_ordered$weight), ]

  # Show most convincing first
  cat(" ", sep = "\n")
  cat("**********************************", sep = "\n")
  cat("* All models (ordered by weight) *", sep = "\n")
  cat("**********************************", sep = "\n")
  cat(" ", sep = "\n")
  knitr::kable(df_ordered)

  # Show weights
  cat(" ", sep = "\n")
  txtplot::txtplot(x = seq(1, length(df_ordered$weight)), y = df_ordered$weight)

  ################################################################################
  # Create a best model data frame
  ################################################################################
  # Show the best model
  best_row_index <- which(df_ordered$marg_log_lik == max(df_ordered$marg_log_lik))
  df_best <- df_ordered[best_row_index, ]
  cat(" ", sep = "\n")
  cat("**********************************", sep = "\n")
  cat("* Best model:                    *", sep = "\n")
  cat("**********************************", sep = "\n")
  cat(" ", sep = "\n")
  knitr::kable(df_best, row.names = FALSE)

}

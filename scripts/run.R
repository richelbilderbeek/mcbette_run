library(mcbette)
library(beautier)

if (can_run_mcbette()) {

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

  interpret_marg_lik_estimates(marg_liks)
}

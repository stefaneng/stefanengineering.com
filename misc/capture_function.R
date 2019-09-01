expr_type <- function(x) {
  if (rlang::is_syntactic_literal(x)) {
    "constant"
  } else if (is.symbol(x)) {
    "symbol"
  } else if (is.call(x)) {
    "call"
  } else if (is.pairlist(x)) {
    "pairlist"
  } else {
    typeof(x)
  }
}

switch_expr <- function(x, ...) {
  switch(expr_type(x),
         ...,
         stop("Don't know how to handle type ", typeof(x), call. = FALSE)
  )
}

replace_vars <- function(x, envi) {
  switch_expr(x,
              # Base cases
              constant = x,
              symbol = {
                # Get the variable from the environment
                rlang::env_get(nm = as.character(x), default = x, env = envi)
              },

              # Recursive cases
              pairlist = purrr::map(x, replace_vars, envi),
              call = {
                res <- purrr::map(x, replace_vars, envi)
                class(res) <- class(x)
                res
              }
  )
}

capture_code <- function(e) {
  e <- rlang::enexpr(e)
  print(ls(all.names = TRUE))
  print("Function: ")
  cf <- get(toString(e[[1]]))
  if(typeof(cf) != "closure") stop(e[[1]], "is not a function")

  # Evalation the named functions first
  # Then fill in the unnamed
  cf_args <- formals(cf)
  called_args <- as.list(e[-1])
  if(!is.null(names(called_args))) {
    not_named <- names(called_args) == ""
    named_args <- called_args[!not_named]
    unnamed_args <-  called_args[not_named]

    new_args <- modifyList(cf_args, named_args)
    missing_args <- unlist(lapply(new_args, rlang::is_missing))
    missing_indices <- seq_along(new_args)[missing_args]
  } else {
    new_args <- cf_args
    unnamed_args <- called_args
    missing_indices <- seq_along(new_args)
  }

  # Add the unnamed arguments
  for(i in seq_along(unnamed_args)) {
    new_args[[missing_indices[[i]]]] <- unnamed_args[[i]]
  }

  # Get the function body from
  cf_func_body <- functionBody(cf)[-1]

  replace_vars(cf_func_body, rlang::new_environment( as.list(new_args)))
}

res <- capture_code(my_scatterplot("My title", xlab = "MPG"))
res

View(res)





capture_code <- function(call) {
  mc <- match.call()[[2]]
  fun <- match.fun(mc[[1]])
  body(fun) <- substitute(substitute(b), list(b = body(fun)))
  mc[[1]] <- as.name("fun")
  eval(mc)
}

capture_code(my_scatterplot("My title", xlab = "MPG"))

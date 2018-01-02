.onLoad <- function(libname = find.package("livestream"), pkgname = "livestream") {
  options(livestream_base_url = "https://livestreamapis.com/v3/")
}


.onUnload <- function(libpath = find.package("oRion")) {
  options(livestream_base_url = "https://livestreamapis.com/v3/")
}

.onDetach <- function(libpath = find.package("oRion")) {
  options(livestream_base_url = "https://livestreamapis.com/v3/")
}

# livestream

![Livestream](https://upload.wikimedia.org/wikipedia/commons/5/53/Livestream_logo-rgb_standard.png)

R Wrapper for [LiveStream API](https://livestream.com/developers/docs/api)*

## Install

```r
devtools::install_github("http://chlxintgitl01.weforum.local/JCOE/livestream",
  credentials = git2r::cred_user_pass("username", "password"))
```

## Example

``` r
# setup credentials
live_setup(key = "xXXx0X00XxX0XxxXXx0xX")

# get account information
(account = live_account())

# search
results <- live_search("Davos")

# list past events
past_events <- live_past_events()

# get info on random past event
event <- live_event(sample(past_events$id, 1))
```

* `GET` calls

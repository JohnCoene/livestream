# livestream

![Livestream](https://upload.wikimedia.org/wikipedia/commons/5/53/Livestream_logo-rgb_standard.png)

R Wrapper for [LiveStream API](https://livestream.com/developers/docs/api)*.

## Install

```r
devtools::install_github("JohnCoene/livestream")
```

## Usage

* All functions start with `live_`. 
* Setup, optionally, API key, account id and event id from `live_setup`

## Example

``` r
# setup credentials
live_setup(key = "xXXx0X00XxX0XxxXXx0xX")

live_options() # retrieve options 

# get account information
(account = live_account())

# search
results <- live_search("useR meetup")

# list past events
past_events <- live_past_events()

# get info on random past event
set.seed(882505)
event <- live_event(sample(past_events$id, 1))

# get videos from event
videos <- live_videos(sample(past_events$id, 1))

# get feed
feed <- live_feed(sample(past_events$id, 1))
```

\* `GET` calls


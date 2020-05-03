# Alephbet
A rails-engine backend for the [Alephbet](https://github.com/alephbet/alephbet) A/B testing framework.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'alephbet'
```

And then execute:
```bash
$ bundle
$ bundle exec rails generate alephbet:install
$ bundle exec rake db:migrate
```

Update your routes to mount alephbet:
```ruby
# config/routes.rb

mount Alephbet::Engine => "/alephbet"
```

Add alephbet JS:
```bash
# with webpacker
$ npm install --save alephbet
```

## Usage

### running experiments

Add javascript experiments:

```javascript
import AlephBet from "alephbet"

// for more options, see https://github.com/alephbet/alephbet

const adapter = new AlephBet.RailsAdapter(
  "http://your.host/alephbet/event"  // URL of the mounted engine tracking action
)

const button_clicked = new AlephBet.Goal("button clicked")

const experiment = new AlephBet.Experiment({
  name: "my experiment",
  tracking_adapter: adapter,
  variants: {
    "1-Blue": {
      activate: () => { /* set button color to blue */ }
    },
    "2-Red": {
      activate: () => { /* set button color to red */ }
    }
  }
})

experiment.add_goals([button_clicked])
```

### viewing results

There's no built-in dashboard at the moment. However, the API is compatible with [Gimel](https://github.com/alephbet/gimel) and [Lamed](https://github.com/alephbet/lamed), the Alephbet backends running on AWS Lamba).

To access your dashboard, run:
```ruby
bundle exec rake alephbet:dashboard
```

The url would include the API url and key (with default namespace), to access your experiment results

### cleaning-up

Alephbet stores unique ids for events in the database, as well as the tally of test results. Those take space and can
also slow down response times. It's therefore advisable to clean-up old experiment data from time to time.

For example:
```ruby
# delete all unique ids (use with care)
> Alephbet::Tracking.delete_all

# delete all unique ids older than 30 days
> Alephbet::Tracking.where("created_at < ?", 30.days.ago).delete_all

# delete all unique ids for experiment "buy button" in namespace "dev"
> Alephbet::Tracking.where(:experiment => "buy button", :namespace => "dev").delete_all

# delete experiment results for experiment "buy button" in namespace "dev"
> Alephbet::Experiment.where(:experiment => "buy button", :namespace => "dev").delete_all
```

## Contributing
Create an issue or submit a pull request.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

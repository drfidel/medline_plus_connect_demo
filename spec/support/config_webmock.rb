require 'webmock/rspec'

# Webmock allows stubbing of external http requests, and disables all other
#  requests outside of localdev.
# Use `WebMock.disable_net_connect! allow_localhost: true` within tests which
#  make external requests (e.g., API calls), and reenable net connections with
#  `WebMock.allow_net_connect!` when finished.

# This begins the test suite allowing external requests.
WebMock.allow_net_connect!

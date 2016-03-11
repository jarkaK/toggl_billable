Toggl-client
==============

Toggl client with main purpose to prepare data for invoicing. It is developed and tested only for the free version of 
Toggl (for now).

This gem is integrated into [iucto_invoicing](https://github.com/jarkadlec/iucto_invoices) 
 
## Install

### Prerequisities

 - ruby v 2.*
 - bundle (You can install using `gem install bundle`) 


Simply Run 

     bundle install

For running tests

    rspec spec
    
 
## Usage
 
     require 'toggl_client'
     TogglClient::Client.start(TOGGL_API_TOKEN)
     
## Contribution
Contribution is highly welcomed. Fork the repo, create a feature branch, create a pull request. 

### TODO

 - Toggle Pro features integration
 - More options to customize output and queries params
 - Implement other features / reports
 
 
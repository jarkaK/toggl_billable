Toggl-client
==============

Toggl client with main purpose to prepare data for invoicing. It is developed and tested only for the free version of 
Toggl (for now). The functionality is very limited and might be extended in future 
 
## Install

### Prerequisities

 - ruby 2.0 or higher
 - bundle (You can install using `gem install bundle`) 


Simply Run 

     bundle install

For running tests

    rspec spec
    
 
## Usage
 
     require 'toggl_client'
     TogglClient::Client.start(TOGGL_API_TOKEN)
     
### Item Format

Item is returned in following format. Format customisation might come as next feature. 

      {
        task: Date: (project) - task,
        amount: 7.5,
        unit: hours
      }
     
## Documentation
    
Better documentation will be added. To get items for last month run sth like that:

    require 'toggl_client'
    
    TogglClient::Client.start(TOGGL_API__TOKEN)
    TogglClient::Reports::Details.new.last_month_billable
    
## Contribution
Contribution is highly welcomed. Fork the repo, create a feature branch, create a pull request. 

### TODO

 - Toggle Pro features integration
 - More options to customize output and queries params
 
 
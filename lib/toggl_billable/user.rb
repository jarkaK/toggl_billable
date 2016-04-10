module TogglBillable
  class User

    def workspaces
      response = Client.api_get('workspaces')
      JSON.parse(response.body)
    end

    def default_workspace_id
      response = Client.api_get('me')
      JSON.parse(response.body)['data']['default_wid']
    end

  end
end
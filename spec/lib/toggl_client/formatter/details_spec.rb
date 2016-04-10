require 'spec_helper'

describe TogglClient::Formatter::Details do
  subject { described_class.new(report).billable_items }

  let(:tasks)   { ['Task X', 'Meetings', 'Task C'] }
  let(:projects) { ['Project 1', 'Project 2'] }
  let(:clients) { ['Client 1', 'Client 2'] }
  let(:items) do
    [{
       "description"=>tasks[0],
       "start"=>"2016-01-29T13:00:00+00:00",
       "end"=>"2016-01-29T13:30:00+00:00",
       "updated"=>"2016-03-12T13:12:18+00:00",
       "dur"=>3600000, # 1 hour
       "user"=>"test_user",
       "client"=>clients[0],
       "project"=>projects[0],
       "task"=>nil,
       "billable"=>nil,
       "is_billable"=>false,
       "cur"=>nil,
       "tags"=>[]
     },{
       "description"=>tasks[1],
       "start"=>"2016-01-05T11:00:00+00:00",
       "end"=>"2016-01-05T13:00:00+00:00",
       "updated"=>"2016-03-12T13:11:52+00:00",
       "dur"=>7200000, # 2 hours,
       "user"=>"test_user",
       "client"=>clients[0],
       "project"=>nil,
       "task"=>nil,
       "billable"=>nil,
       "is_billable"=>false,
       "cur"=>nil,
       "tags"=>[]
     },{
       "description"=>tasks[0],
       "start"=>"2016-01-15T09:00:00+00:00",
       "end"=>"2016-01-15T11:00:00+00:00",
       "updated"=>"2016-03-12T13:12:09+00:00",
       "dur"=>4680000, # 1.3 hours
       "user"=>"test_user",
       "client"=>clients[0],
       "project"=>projects[0],
       "task"=>nil,
       "billable"=>nil,
       "is_billable"=>false,
       "cur"=>nil,
       "tags"=>[]
     },{
       "description"=>tasks[0],
       "start"=>"2016-01-16T09:00:00+00:00",
       "end"=>"2016-01-16T11:00:00+00:00",
       "updated"=>"2016-03-12T13:12:09+00:00",
       "dur"=>3600000, # 1 hours
       "user"=>"test_user",
       "client"=>clients[0],
       "project"=>projects[1],
       "task"=>nil,
       "billable"=>nil,
       "is_billable"=>false,
       "cur"=>nil,
       "tags"=>[]
     },{
       "description"=>tasks[2],
       "start"=>"2016-01-29T07:00:00+00:00",
       "end"=>"2016-01-29T09:00:00+00:00",
       "updated"=>"2016-03-12T13:12:37+00:00",
       "dur"=>7200000, # 2 hours
       "user"=>"test_user",
       "client"=>clients[1],
       "project"=>projects[1],
       "task"=>nil,
       "billable"=>nil,
       "is_billable"=>false,
       "cur"=>nil,
       "tags"=>[]
     },{
       "description"=>tasks[0],
       "start"=>"2016-01-10T07:00:00+00:00",
       "end"=>"2016-01-10T09:00:00+00:00",
       "updated"=>"2016-03-12T13:12:37+00:00",
       "dur"=>7200000, # 2 hours
       "user"=>"test_user",
       "client"=>nil,
       "project"=>projects[1],
       "task"=>nil,
       "billable"=>nil,
       "is_billable"=>false,
       "cur"=>nil,
       "tags"=>[]
     }]
  end
  let(:report) do
    {
      "total_grand"=>130680000,
      "total_billable"=>nil,
      "total_currencies"=>[{"currency"=>nil, "amount"=>nil}],
      "total_count"=>4,
      "per_page"=>50,
      "data"=>items

    }
  end
  let(:expected_items_client1) do
    [
      {
        task: "Jan 15-29: #{projects[0]}: #{tasks[0]}",
        amount: 2.25,
        unit: :hours
      },{
        task: "Jan: #{tasks[1]}",
        amount: 2.0,
        unit: :hours
      },{
      task: "Jan 16: #{projects[1]}: #{tasks[0]}",
      amount: 1.0,
      unit: :hours
    }
    ]
  end

  it 'should contain data in correct format' do
    subject.each do |client, data|
      data.each do |item|
        expect(item.keys).to match_array([:task, :amount, :unit])
      end
    end
  end

  it 'should return data for 3 clients' do
    expect(subject.size).to eq(3)
  end

  it 'should return data with clients as keys' do
    expect(subject.keys).to match_array(clients + ['NO_CLIENT'])
  end

  it 'should return correct amount of items for each client' do
    result = subject
    expect(result[clients[0]].size).to  eq(3)
    expect(result[clients[1]].size).to  eq(1)
    expect(result['NO_CLIENT'].size).to eq(1)
  end

  it 'should return items in correct format' do
    expect(subject[clients[0]]).to eq(expected_items_client1)
  end

end
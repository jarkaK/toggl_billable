# 'text' => item[:task],
# 'amount' => item[:duration],
# 'unit' => 'hours',
#   'vat' => '0',
#   'price' => '27',
#   'accountentrytype_id' => '15',
#   'vattype_id' => '4'

require 'spec_helper'

describe TogglClient::Formatter::Summary do
  context '#billable_items' do
    subject { described_class.new(report).billable_items }
    let(:projects) { ['project 1', 'project 2', 'project 3'] }
    let(:clients)  { ['client 1', 'client 2'] }
    let(:tasks)    { ['task A', 'task B', 'task C', 'task D'] }
    let(:report) do
      {
        "total_grand"=>63900000,
        "total_billable"=>nil,
        "total_currencies"=>[{"currency"=>nil, "amount"=>nil}],
        "data"=>
          [{"id"=>14315467,
            "title"=>{"project"=>projects[0], "client"=>clients[0], "color"=>"7", "hex_color"=>"#268bb5"},
            "time"=>34200000,
            "total_currencies"=>[{"currency"=>nil, "amount"=>nil}],
            "items"=>[
              {"title"=>{"time_entry"=>tasks[0]}, "time"=>27000000, "cur"=>nil, "sum"=>nil, "rate"=>nil},
              {"title"=>{"time_entry"=>tasks[1]}, "time"=>7200000, "cur"=>nil, "sum"=>nil, "rate"=>nil}]
           },
           {"id"=>14315468,
            "title"=>{"project"=>projects[1], "client"=>clients[0], "color"=>"0", "hex_color"=>"#4dc3ff"},
            "time"=>8100000,
            "total_currencies"=>[{"currency"=>nil, "amount"=>nil}],
            "items"=>[{"title"=>{"time_entry"=>tasks[0]}, "time"=>8100000, "cur"=>nil, "sum"=>nil, "rate"=>nil}]
           },
           {"id"=>14315468,
            "title"=>{"project"=>projects[2], "client"=>clients[1], "color"=>"0", "hex_color"=>"#4dc3ff"},
            "time"=>8100000,
            "total_currencies"=>[{"currency"=>nil, "amount"=>nil}],
            "items"=>[{"title"=>{"time_entry"=>tasks[1]}, "time"=>8100000, "cur"=>nil, "sum"=>nil, "rate"=>nil}]
           },
           {"id"=>14315476,
            "title"=>{"project"=>projects[3], "client"=>nil, "color"=>"1", "hex_color"=>"#bc85e6"},
            "time"=>21600000,
            "total_currencies"=>[{"currency"=>nil, "amount"=>nil}],
            "items"=>[{"title"=>{"time_entry"=>tasks[4]}, "time"=>21600000, "cur"=>nil, "sum"=>nil, "rate"=>nil}]}
          ]
      }
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

    it 'should format data correctly' do
      result = subject
      data = result[clients[0]]

      expect(data[0][:task]).to   eq("#{projects[0]}: #{tasks[0]}")
      expect(data[0][:amount]).to eq(7.5)
      expect(data[0][:unit]).to   eq(:hours)

      expect(data[1][:task]).to   eq("#{projects[0]}: #{tasks[1]}")
      expect(data[1][:amount]).to eq(2.0)
      expect(data[1][:unit]).to   eq(:hours)

      expect(data[2][:task]).to   eq("#{projects[1]}: #{tasks[0]}")
      expect(data[2][:amount]).to eq(2.25)
      expect(data[2][:unit]).to   eq(:hours)
    end

  end
end


require 'spec_helper'

describe TogglBillable::User do

  context '#workspaces' do
    subject { TogglBillable::User.new.workspaces }

    it 'should return workspaces' do
      expect(subject.count).to be >= 0
    end

    it 'should have needed keys' do
      expect(subject.first.keys).to include('id', 'name', 'name', 'premium', 'default_hourly_rate',
         'default_currency', 'only_admins_may_create_projects', 'only_admins_see_billable_rates', 'rounding',
         'rounding_minutes')
    end
  end

  context '#default_workspace_id' do
    subject { TogglBillable::User.new.default_workspace_id }

    it 'should return integer' do
      expect(subject).to be_instance_of(Fixnum)
    end

    it 'should return positive id' do
      expect(subject).to be >= 0
    end
  end
end
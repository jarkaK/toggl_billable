require 'spec_helper'

describe TogglClient::Reports::Summary do

  context '#get_report' do
    context 'default params' do
      subject { described_class.new.get_report(start_date: '2016-01-01', end_date: '2016-02-01') }

      it 'should contain correct keys' do
        expect(subject.keys).to match_array(['total_grand', 'total_billable', 'total_currencies', 'data'])
      end

      it 'total_grand should be numeric' do
        expect(subject['total_grand']).to be_instance_of(Fixnum)
      end
    end
  end

  context '#last_month_billable' do
    subject { obj.last_month_billable }

    let(:obj)       { described_class.new }
    let(:report)    { double }
    let(:formatter) { double }
    let(:dates) do
      {
        start_date: '2015-03-01',
        end_date: '2015-03-31'
      }
    end

    before do
      Timecop.freeze('2015-04-25')
      obj.should_receive(:get_report).with(dates).and_return(report)
      TogglClient::Formatter::Summary.should_receive(:new).with(report, {}).and_return(formatter)
      formatter.should_receive(:billable_items).and_return(double)
    end

    it 'should call correct class' do
      subject
    end
  end

end
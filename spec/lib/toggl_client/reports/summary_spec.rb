require 'spec_helper'

describe TogglClient::Reports::Summary do

  context '#get_report' do
    context 'default params' do
      subject { described_class.new.get_report('2016-01-01', '2016-02-01') }

      it 'should contain correct keys' do
        expect(subject.keys).to match_array(['total_grand', 'total_billable', 'total_currencies', 'data'])
      end

      it 'total_grand should be numeric' do
        expect(subject['total_grand']).to be_instance_of(Fixnum)
      end
    end

  end

  context '#billable_items' do
    subject { obj.billable_items }

    let(:obj)       { described_class.new }
    let(:report)    { double }
    let(:formatter) { double }

    before do
      obj.report = report
      TogglClient::Formatter::Summary.should_receive(:new).with(report).and_return(formatter)
      formatter.should_receive(:billable_items).and_return(double)
    end

    it 'should call correct class' do
      subject
    end
  end

end
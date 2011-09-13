shared_examples_for 'successful json response' do
  subject { response }
  specify { should be_success }
  its(:content_type) { should == 'application/json' }
end
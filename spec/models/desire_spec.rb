require 'spec_helper'

describe Desire do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @desire = user.desires.build(content: "Lorem ipsum")
  end

  subject { @desire }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
	its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Desire.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
  	before { @desire.user_id = nil }
  	it { should_not be_valid }
  end

  describe "with blank content" do
    before { @desire.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @desire.content = "a" * 1025 }
    it { should_not be_valid }
  end

end

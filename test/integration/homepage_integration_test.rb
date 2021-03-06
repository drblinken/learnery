require "test_helper"

describe "Homepage Integration Test" do
 
  it "may be empty" do
    visit root_path
    page.must_have_content('Nothing Planned')
    page.must_have_link('New')
  end

  context "with events" do
    before do 
      future_event = Event.create!( :name => "event in the future", :starts => Date.today + 30 )
      next_event   = Event.create!( :name => "the very next event", :starts => Date.today + 10 )
      past_event   = Event.create!( :name => "event in the past",   :starts => Date.today - 10 )
    end
    it "shows upcoming events" do
      visit root_path
      page.wont_have_content('event in the past')
      page.must_have_content('the very next event')
      page.must_have_content('event in the future')
    end
   
    it "shows event in the pasts with param past=true" do
      visit root_path(past: true)
      page.must_have_content('event in the past')
      page.wont_have_content('the very next event')
      page.wont_have_content('event in the future')
    end
  end
end

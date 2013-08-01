require 'spec_helper'

describe HomeController do

  describe "GET 'tv'" do
    it "returns http success" do
      get 'tv'
      response.should be_success
    end
  end

end

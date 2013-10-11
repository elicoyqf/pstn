require 'spec_helper'

describe GponController do

  describe "GET 'preconfig'" do
    it "returns http success" do
      get 'preconfig'
      response.should be_success
    end
  end

end

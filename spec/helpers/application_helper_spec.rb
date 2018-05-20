require 'rails_helper'

describe ApplicationHelper do
  describe "full_titleメソッド" do
    it "引数無し呼び出し時に期待する値を返すこと" do
      expect(full_title).to eq "Ruby on Rails Tutorial Sample App"
    end

    it "引数あり呼び出し時に期待する値を返すこと" do
      expect(full_title("Help")).to eq "Help | Ruby on Rails Tutorial Sample App"
    end
  end
end

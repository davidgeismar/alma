require("foo")
require("bar")
require("foobar")
require("manager.rb")
require("action_decision_center.rb")
require("pry-byebug")

RSpec.describe ActionDecisionCenter, "compare_production_improvement_ratio" do
  context "bla" do
    it "calculates what is the best decision between upgrading and buying" do
      manager = Manager.new
      manager.available_funds = 100
      manager.set_bot_count(10)
      action_decision_center = ActionDecisionCenter.new(manager)
      action = action_decision_center.compare_production_improvement_ratio
      expect(action).to eq :buy_bot
    end
    it "calculates what is the best decision between upgrading and buying" do
      manager = Manager.new
      manager.available_funds = 100
      manager.set_bot_count(120)
      action_decision_center = ActionDecisionCenter.new(manager)
      action = action_decision_center.compare_production_improvement_ratio
      expect(action).to eq :upgrade
    end
  end
end

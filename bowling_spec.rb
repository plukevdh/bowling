require 'bowling'

describe Bowling, "#score" do
  before(:each) do
    @bowling = Bowling.new
  end

  it "returns 0 for all gutter game" do
    20.times do
      @bowling.hit(0)
    end
    @bowling.score.should == 0
  end

  it "returns correct score for open frame" do
    @bowling.hit(3)
    @bowling.hit(6)
    @bowling.score.should == 9
  end

  it "returns correct score for spare" do
    @bowling.hit(7)
    @bowling.hit(3)
    @bowling.hit(4)
    
    @bowling.score(1).should == 14
  end

  it "returns correct total for open frame after spare" do
    @bowling.hit(7)
    @bowling.hit(3)
    @bowling.hit(4)
    @bowling.hit(2)
    
    @bowling.score.should == 20
  end
  

  it "returns correct score for open frame after strike" do
    @bowling.hit(10)
    @bowling.hit(3)
    @bowling.hit(6)

    @bowling.score(1).should == 19
  end

  it "returns correct game total for open frame after strike" do  
    @bowling.hit(10)
    @bowling.hit(3)
    @bowling.hit(6)
    
    @bowling.score.should == 28
  end

  it "returns correct score for strike after a strike" do
    @bowling.hit(10)
    @bowling.hit(10)
    @bowling.hit(3)

    @bowling.score(1).should == 23
  end
  
  it "returns correct score after 2 frames for strike after strike" do
    @bowling.hit(10)
    @bowling.hit(10)
    @bowling.hit(10)
    @bowling.hit(10)

    @bowling.score(1).should == 30
    @bowling.score(2).should == 60
    
  end

  it "returns correct game total for perfect game" do
    12.times do
      @bowling.hit(10)
    end

    @bowling.score.should == 300
  end

  it "returns correct game total for my best game" do
    @bowling.hit(10)
    @bowling.hit(10)
    @bowling.hit(10)
    @bowling.hit(10)
    @bowling.hit(10)

    @bowling.hit(7)
    @bowling.hit(3)

    @bowling.hit(10)

    @bowling.hit(9)
    @bowling.hit(0)
    
    @bowling.hit(8)
    @bowling.hit(0)

    @bowling.hit(8)
    @bowling.hit(1)
    
    @bowling.score.should == 202
  end
  
end

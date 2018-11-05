# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Reshape do
  after do
    Reshape.reset
  end

  describe ".respond_to?" do
    it "should be true if method exists" do
      Reshape.respond_to?(:new, true).should be true
    end
  end

  describe ".new" do
    it "should be a Reshape::Client" do
      Reshape.new.should be_a Reshape::Client
    end
  end

end

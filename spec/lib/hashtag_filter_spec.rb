require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
require 'hashtag_filter'

describe HashtagFilter do
  before do
    @filter = HashtagFilter.new({})
  end

  it 'enables process normal text' do
    @filter.process("test").should == "test"
  end

  it 'enables process hash' do
    url = Rails.application.routes.url_helpers.url_for(:controller => :search, :action => :search, :search => {:message => "#test"}, :only_path => true)
    @filter.process("#test").should == "<a href=\"#{url}\">#test</a>"
  end

  it 'enables process text with hash' do
    url = Rails.application.routes.url_helpers.url_for(:controller => :search, :action => :search, :search => {:message => "#test"}, :only_path => true)
    @filter.process("a #test is hash").should == "a <a href=\"#{url}\">#test</a> is hash"
  end

  it 'enables process multiple hash' do
    aaa_url = Rails.application.routes.url_helpers.url_for(:controller => :search, :action => :search, :search => {:message => "#aaa"}, :only_path => true)
    bbb_url = Rails.application.routes.url_helpers.url_for(:controller => :search, :action => :search, :search => {:message => "#bbb"}, :only_path => true)
    @filter.process("multiple hashes #aaa and #bbb").should == "multiple hashes <a href=\"#{aaa_url}\">#aaa</a> and <a href=\"#{bbb_url}\">#bbb</a>"
  end
end

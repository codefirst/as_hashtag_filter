class HashtagFilter < AsakusaSatellite::Filter::Base
  include ActionView::Helpers::UrlHelper
  include Rails.application.routes.url_helpers

  def process(text, opts={})
    text.gsub(/(#\w+)/) do
      link_to($1, :controller => :search, :action => :search, :search => { :message => $1 }, :only_path => true)
    end
  end

  private
  def controller
    @controller
  end

end

class PufferPages::PagePart < ActiveRecord::Base
  self.abstract_class = true

  belongs_to :page, :class_name => '::Page'

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :page_id

  def render(drops_or_context, page = page)
    template = Liquid::Template.parse(body)
    result = tracker.cleanup template.render(drops_or_context,  :registers => {:tracker => tracker, :page => page, :file_system => PufferPages::Liquid::FileSystem.new})
    main? ? result : "<% content_for :'#{name}' do %>#{result}<% end %>"
  end

  def tracker
    @tracker ||= PufferPages::Liquid::Tracker.new
  end

  def main?
    name == PufferPages.primary_page_part_name
  end

end

module PufferPagesHelper

  def possible_layouts
    inherited_layout + (application_layouts + puffer_layouts).sort
  end

  def application_layouts
    view_paths.map {|path| Dir.glob("#{path}/layouts/[^_]*")}.flatten.map {|path| File.basename(path).gsub(/\..*$/, '')}.uniq
  end

  def puffer_layouts
    Layout.order(:name).all.map(&:name)
  end

  def inherited_layout
    record.inherited_layout_name ? [[t('puffer.inherited_layout', :name => record.inherited_layout_name), '']] : []
  end

end

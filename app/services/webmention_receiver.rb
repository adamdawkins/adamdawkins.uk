class WebmentionReceiver
  attr_reader :source_doc, :source, :target
  def initialize(source, target)
    @source = source
    @target = target
    @source_doc = HTTParty.get(source)
    pp HTTParty.head(@target)
  end
end

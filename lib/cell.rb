class Cell

  attr_accessor :content

  def initialize(content)
    @content = content
    @shot_at = false
  end

  def hit!
    @shot_at = true
    @content.hit!
  end

  def hit?
    @content.hit?
  end

  def shot_at?
    @shot_at
  end

end

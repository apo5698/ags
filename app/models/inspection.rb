class Inspection < RubricItem
  def title
    'Inspection'
  end

  def usage
    'This step renders the selected input file.'
  end

  def self.model_name
    RubricItem.model_name
  end
end

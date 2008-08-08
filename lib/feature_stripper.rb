class FeatureStripper
  def self.strip(doc, feature)
    output = []
    state = :beforefeature
    doc.each_line do |line|
      case line
      when /.*<% feature :#{feature} do -?%>.*/
        state = :infeature
      when /.*<% end #feature:#{feature} -?%>.*/
        state = :afterfeature
      else
        output << line
      end
    end
    
    raise "end of feature not found" if state == :infeature
    
    return output.join('')
  end
end
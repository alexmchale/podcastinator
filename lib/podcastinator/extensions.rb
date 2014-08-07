class Object

  def present?
    !blank?
  end

  def blank?
    return true if self == nil
    return true if kind_of?(String) && self =~ /\A\s*\z/
    return true if respond_to?(:length) && length == 0
    return true if to_s.length == 0
    return false
  end

end

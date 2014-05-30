
module MagicAttributes
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    
    
    
    def magic_attributes(*attrs)
      attrs = attrs.first if attrs.is_a?(Array)
      
      attrs.each_key do |attr_name|
        if attrs[attr_name].is_a?(Array)
          define_method(attr_name) do
            calls = attrs[attr_name].dup
            obj = self # start with the current object
            calls.each do |call|
              obj = obj.send(call)
              return nil if obj.nil?
            end
            return obj
          end
          
        elsif attrs[attr_name].is_a?(Proc)
          define_method(attr_name) do
            attrs[attr_name].call(self)
          end 
        else
          # Else just return the value
          define_method(attr_name) do
            attrs[attr_name]
          end 
        end
      end
      
      
    end
  end

end


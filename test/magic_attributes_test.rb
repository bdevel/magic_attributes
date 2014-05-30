require 'magic_attributes'
require "minitest/autorun"


describe MagicAttributes do
  
  before do
    class A
      attr_accessor :b
      def initialize
        @b = B.new
      end
    end
    
    class B
      attr_accessor :c
      def initialize
        @c = C.new
      end
    end
    
    class C
      def value
        return 'YES!'
      end
    end
    
  end
  
  it "should flatten attributes" do
    class MyA < A
      include MagicAttributes
      magic_attributes(:c_value => [:b, :c, :value])
    end
    my_a = MyA.new
    assert_equal 'YES!', my_a.c_value
  end
  
  it "should return nil one of the attributes is nil" do
    class MyA < A
      include MagicAttributes
      magic_attributes(:c_value => [:b, :c, :value])
    end
    my_a = MyA.new
    my_a.b.c = nil
    assert_equal nil, my_a.c_value
  end
  
  it "should call the block with the current object" do
    class MyA < A
      include MagicAttributes
      magic_attributes(:c_value_reversed => -> (obj) {obj.b.c.value.reverse})
    end
    my_a = MyA.new
    assert_equal '!SEY', my_a.c_value_reversed
  end
  
  it "should return the value if not an array or a Proc" do
    class MyA < A
      include MagicAttributes
      magic_attributes(:a_string => 'My String',
                       :a_numeric => 33.0,
                       :a_hash => {:foo => 'bar'}
                       )
    end
    my_a = MyA.new
    assert_equal 'My String', my_a.a_string
    assert_equal 33.0, my_a.a_numeric
    assert_equal( {:foo => 'bar'}, my_a.a_hash)
  end
  
  
  
  
end


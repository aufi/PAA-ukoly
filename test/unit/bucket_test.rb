# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'bucket'

class BucketTest < Test::Unit::TestCase
  def test_bucket_should_empty
    b = Bucket.new(10, 4, 0)
    assert_equal(b.state, 4)
    b.empty
    assert_equal(b.state, 0)
  end
  
  def test_bucket_should_fill
    b = Bucket.new(10, 3, 0)
    assert_equal(b.state, 3)
    b.fill
    assert_equal(b.state, 10)
  end
  
  def test_bucket_should_move_to_empty
    a = Bucket.new(10, 4, 0)
    b = Bucket.new(10, 4, 0)
    b.move(a)
    assert_equal(b.state, 0)
    assert_equal(a.state, 8)
  end
  
  def test_bucket_should_move_to_full
    a = Bucket.new(10, 8, 0)
    b = Bucket.new(10, 4, 0)
    b.move(a)
    assert_equal(b.state, 2)
    assert_equal(a.state, 10)
  end
end

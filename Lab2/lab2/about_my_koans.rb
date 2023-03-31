require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutMyCoans < Neo::Koan
    def test_1
        hash = {name: "John", age: 30, city: "New York"}
        assert_equal true, hash.has_key?(:name) #true
    end

    def test_2
        array = [1, 2, 3, 4]
        array << 5
        assert_equal "[1, 2, 3, 4, 5]", array.inspect #"[1, 2, 3, 4, 5]"
    end

    def test_3
        array = [1, 2, 3, 4]
        assert_equal 4, array.last # 4
    end

    def test_4
        string = "Hello, world!"
        assert_equal 13, string.length # 13
    end

    def test_5
        string = ""
        assert_equal true, string.empty? # true
    end

    def test_6
        bool=true&false
        assert_equal false, bool #false
    end

    def test_7
        str1="Hello"
        str2=str1
        str1="World"
        assert_equal "Hello", str2 #"Hello"
    end

    def test_8
        string = "Hello, world!"
        assert_equal true, string.include?("world") # true
    end

    def test_9
        array = [1, 2, 3, 4, 5]
        array.clear
        assert_equal "[]", array.inspect # "[]"
    end

    def test_10
       add=10+20
       add2=add
       add=20-15
       assert_equal 30, add2 #30
    end

end
require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutClasses < Neo::Koan
  class Dog
  end

  def test_instances_of_classes_can_be_created_with_new #тестує можливість створення екземплярів класів за допомогою методу new.
    fido = Dog.new
    assert_equal Dog, fido.class
  end

  # ------------------------------------------------------------------

  class Dog2
    def set_name(a_name)
      @name = a_name
    end
  end

  def test_instance_variables_can_be_set_by_assigning_to_them #тестує можливість встановлення значення змінної екземпляру класу за допомогою методу, який встановлює ім'я собаки.
    fido = Dog2.new
    assert_equal [], fido.instance_variables

    fido.set_name("Fido")
    assert_equal [:@name], fido.instance_variables
  end

  def test_instance_variables_cannot_be_accessed_outside_the_class #перевіряється, що інстанс змінна не може бути доступна ззовні класу.
    fido = Dog2.new
    fido.set_name("Fido")

    assert_raise(NoMethodError) do
      fido.name
    end

    assert_raise(SyntaxError) do
      eval "fido.@name"
      # NOTE: Using eval because the above line is a syntax error.
    end
  end

  def test_you_can_politely_ask_for_instance_variable_values #Цей тест дозволяє перевірити правильність роботи методу instance_variable_get, який дозволяє отримувати значення змінних екземпляра в Ruby.
    fido = Dog2.new
    fido.set_name("Fido")

    assert_equal "Fido", fido.instance_variable_get("@name")
  end

  def test_you_can_rip_the_value_out_using_instance_eval #еревіряє, чи можна отримати значення змінної екземпляра @name з об'єкта fido за допомогою методу instance_eval.
    fido = Dog2.new
    fido.set_name("Fido")

    assert_equal "Fido", fido.instance_eval("@name")  # string version
    assert_equal "Fido", fido.instance_eval { @name } # block version
  end

  # ------------------------------------------------------------------

  class Dog3
    def set_name(a_name)
      @name = a_name
    end

    def name
      @name
    end
  end

  def test_you_can_create_accessor_methods_to_return_instance_variables #перевіряє, чи можна створити акцесорний метод для отримання значення змінної екземпляра @name з об'єкта fido класу Dog3.
    fido = Dog3.new
    fido.set_name("Fido")

    assert_equal "Fido", fido.name
  end

  # ------------------------------------------------------------------

  class Dog4
    attr_reader :name

    def set_name(a_name)
      @name = a_name
    end
  end

  def test_attr_reader_will_automatically_define_an_accessor #перевіряє, чи можна використовувати метод attr_reader для автоматичного створення акцесорного методу name для отримання значення змінної екземпляра @name з об'єкта fido класу Dog4.v
    fido = Dog4.new
    fido.set_name("Fido")

    assert_equal "Fido", fido.name
  end

  # ------------------------------------------------------------------

  class Dog5
    attr_accessor :name
  end

  def test_attr_accessor_will_automatically_define_both_read_and_write_accessors #перевірка, що метод attr_accessor автоматично визначає геттер та сеттер для поля класу.
    fido = Dog5.new

    fido.name = "Fido"
    assert_equal "Fido", fido.name
  end

  # ------------------------------------------------------------------

  class Dog6
    attr_reader :name

    def initialize(initial_name)
      @name = initial_name
    end
  end

  def test_initialize_provides_initial_values_for_instance_variables #Перевірка того, що метод започаткування класу задає початкові значення для змінних примірників.
    fido = Dog6.new("Fido")
    assert_equal "Fido", fido.name
  end

  def test_args_to_new_must_match_initialize #перевірка, що під час створення об'єкта класу з допомогою методу new має бути передано правильну кількість аргументів.
    assert_raise(ArgumentError) do
      Dog6.new
    end
    # THINK ABOUT IT:
    # Why is this so?
    # => The initialize method in Dog6 class expects one argument, so if it's not provided, it will raise an ArgumentError.
  end
  def test_different_objects_have_different_instance_variables #перевірка, що різні об'єкти класу мають різні змінні екземпляри.
    fido = Dog6.new("Fido")
    rover = Dog6.new("Rover")

    assert_equal true, rover.name != fido.name
  end

  # ------------------------------------------------------------------

  class Dog7
    attr_reader :name

    def initialize(initial_name)
      @name = initial_name
    end

    def get_self
      self
    end

    def to_s
      @name
    end

    def inspect
      "<Dog named '#{name}'>"
    end
  end

  def test_inside_a_method_self_refers_to_the_containing_object #перевірка того, що всередині методу self посилається на поточний об'єкт.
    fido = Dog7.new("Fido")

    fidos_self = fido.get_self
    assert_equal fido, fidos_self
  end

  def test_to_s_provides_a_string_version_of_the_object #перевірка, що метод to_s повертає рядкове уявлення об'єкта.
    fido = Dog7.new("Fido")
    assert_equal "Fido", fido.to_s
  end

  def test_to_s_is_used_in_string_interpolation #перевірка, що метод to_s використовується у рядковій інтерполяції.
    fido = Dog7.new("Fido")
    assert_equal "My dog is Fido", "My dog is #{fido}"
  end

  def test_inspect_provides_a_more_complete_string_version #перевірка, що метод inspect повертає рядкове подання об'єкта з додатковою інформацією
    fido = Dog7.new("Fido")
    assert_equal "<Dog named 'Fido'>", fido.inspect
  end

  def test_all_objects_support_to_s_and_inspect #перевіряє, чи підтримують всі об'єкти в Ruby методи to_s та inspect.
    array = [1,2,3]

    assert_equal "[1, 2, 3]", array.to_s
    assert_equal "[1, 2, 3]", array.inspect

    assert_equal "STRING", "STRING".to_s
    assert_equal "\"STRING\"", "STRING".inspect
    end

end

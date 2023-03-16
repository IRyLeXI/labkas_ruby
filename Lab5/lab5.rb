module Commands
    class Command
        def execute res, secnumber=nil
        end
    end

    class Invoker
        def initialize
            @commands=Hash.new
        end

        def registerCommand commandName, command
            #puts command.is_a? Command
            @commands[commandName] = command if command.is_a? Command and @commands[commandName].is_a? NilClass
            #puts @commdands
        end

        def executeCommand commandName, res, secnumber
            @command = @commands[commandName]
            #puts @commands
            unless @command.is_a? NilClass
                @command.execute(res, secnumber)
            else
                raise TypeError.new
            end
        end

        def check
            puts @commands
        end
    end

    class PlusCommand < Command
        def execute res, secnumber
            return res+=secnumber
        end
    end

    class MinusCommand < Command
        def execute res, secnumber
            return res-=secnumber
        end
    end

    class MultipleCommand < Command
        def execute res, secnumber
            return res*=secnumber
        end
    end

    class DivisionCommand < Command
        def execute res, secnumber
            return res/=secnumber
        end
    end

    class ModCommand < Command
        def execute res, secnumber
            return res%=secnumber
        end
    end

    class PowCommand < Command
        def execute res, secnumber
            return res**=secnumber
        end
    end

    class SqrtCommand < Command
        def execute res, secnumber=nil
            return Math.sqrt(res)
        end
    end

    class SinCommand < Command
        def execute res, secnumber=nil
            return Math.sin(res)
        end
    end

    class CosCommand < Command
        def execute res, secnumber=nil
            return Math.cos(res)
        end
    end

    class TanCommand < Command
        def execute res, secnumber=nil
            return Math.tan(res)
        end
    end

    class ExpCommand < Command
        def execute res, secnumber=nil
            return Math.exp(res)
        end
    end

    class LnCommand < Command
        def execute res, secnumber=nil
            return Math.log(res)
        end
    end

    class FactorialCommand < Command
        def fact(n)
            return 1 if n <= 1
            n * fact(n-1)
        end

        def execute res, secnumber=nil
            return fact(res)
        end
    end 
end    


module Calculator
    include Commands
    $stack =[]

    def self.primes(n)
        for i in (1..n)
            isprime=true
            for j in (2..Math.sqrt(i).floor)
                if i%j==0
                    isprime=false
                    break
                end
            end
            if isprime
                $stack.push(i)
            end    
        end
    end 

    def self.calculate(res, op, secnumber = nil)                                                                  #операції
        invoker = Invoker.new

        case op
        when "+"
            invoker.registerCommand('+', PlusCommand.new)
            res=invoker.executeCommand('+', res, secnumber)
        when "-"
            invoker.registerCommand('-', MinusCommand.new)
            res=invoker.executeCommand('-', res, secnumber)
        when "*"
            invoker.registerCommand('*', MultiplyCommand.new)
            res=invoker.executeCommand('*', res, secnumber)
        when "/"
            if secnumber == 0
                puts "Division by 0 error!"
                exit
            else
                invoker.registerCommand('/', DivisionCommand.new)
                res=invoker.executeCommand('/', res, secnumber)
            end
        when "--"
            res-=1    
        when "mod"
            invoker.registerCommand('mod', ModCommand.new)
            res=invoker.executeCommand('mod', res, secnumber)
        when "pow"
            invoker.registerCommand('pow', PowCommand.new)
            res=invoker.executeCommand('pow', res, secnumber)
        when "sqrt"
            invoker.registerCommand('sqrt', SqrtCommand.new)
            res=invoker.executeCommand('sqrt', res, secnumber)
        when "sin"
            invoker.registerCommand('sin', SinCommand.new)
            res=invoker.executeCommand('sin', res, secnumber)
        when "cos"
            invoker.registerCommand('cos', CosCommand.new)
            res=invoker.executeCommand('cos', res, secnumber)
        when "tan"
            invoker.registerCommand('tan', TanCommand.new)
            res=invoker.executeCommand('tan', res, secnumber)
        when "ctan"
            invoker.registerCommand('tan', TanCommand.new)
            res=1/invoker.executeCommand('tan', res, secnumber)
        when "exp"
            invoker.registerCommand('exp', ExpCommand.new)
            res=invoker.executeCommand('exp', res, secnumber)
        when "ln"
            invoker.registerCommand('ln', LnCommand.new)
            res=invoker.executeCommand('ln', res, secnumber)
        when "!"
            if res<0
                puts "Number is less than zero!"
                exit
            else
                invoker.registerCommand('!', FactorialCommand.new)
                res=invoker.executeCommand('!', res, secnumber)
            end 
        when "push"
            $stack.push(res)
        when "pop"
            if $stack.empty?
                puts "ERROR!!@!!!!@###!##!#!"
                exit
            end 
            res=$stack[$stack.length-1]
            $stack.pop()  
        when "primes"
            primes(secnumber)
            res=$stack[$stack.length-1]       
        else
            puts "There are no operations with this name!"
            exit
        end
        #invoker.check
        return res
    end

    puts "Calculator has started!"                                                                         #старт

    memory = nil

    puts "First number: "

    res = gets.chomp.to_f

    op=""

    while op!="end"                                                                                         #цикл
        #puts "Choose op +, -, *, /, mod, pow, sqrt, sin, cos, tan, ctan, exp, ln, !, memw, end"

        op = gets.chomp
  
        if op == "end"
            break
        end

        if op=="memw"
            puts "#{res} remembered"
            memory = res       
        else    
            if ["sqrt", "sin", "cos", "tan", "ctan", "exp", "ln", "!", "--", "push", "pop"].include?(op)
                res=calculate(res,op)
            elsif ["+", "-", "*", "/", "mod", "pow", "primes"].include?(op)
                puts "Second number (or memr)"
                secnumber = gets.chomp
                if secnumber=="memr"
                    if memory==nil
                        puts "Error! No data!"
                        exit               
                    else
                        secnumber = memory
                        puts secnumber
                    end
                else
                    secnumber=secnumber.to_f                   
                end
                res = calculate(res, op, secnumber)  
            else                                                                     #push в стек коли число спочатку
                res=op.to_f
                op=gets.chomp
                res=calculate(res, op)         
            end 
        puts "Result: #{res}"   
        end
    
    end 
    
    puts "PAKA"

end



